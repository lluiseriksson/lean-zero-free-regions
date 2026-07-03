import LeanZeroFreeRegions.ZeroFree

/-!
# M0 upgraded to a region: the Kotecky-Preiss zero-free polydisc

The mother repository's `KPCriterion` depends on the activity only through
its NORM, so it is monotone under pointwise domination of activities.
Consequence: a single KP weight certifies nonvanishing of the partition
function not at one activity but on the whole closed polydisc
`{z' : ‖z'(X)‖ ≤ ‖z(X)‖ for all X}` — this is the honest content of "Z ≠ 0
on the convergence polydisc" declared as the M0 gap at T0.

The one-complex-parameter section `w ↦ Ξ(w · z)` is moreover proved to be a
polynomial in `w`, hence entire; combined with the disc nonvanishing this is
the M1 substrate (analytic log on the disc is stated on the frontier).

References: Kotecky-Preiss (1986); Dobrushin (1996); Sokal (2001),
Proposition 2.1 and the surrounding discussion of activity domains;
Friedli-Velenik (2017), Theorem 5.4.
-/

namespace LeanZeroFreeRegions
namespace KP

open scoped Classical BigOperators
open YangMills.KP

/-- The same polymer combinatorics with a replaced activity. -/
def _root_.YangMills.KP.PolymerSystem.withActivity
    (P : PolymerSystem) (z : P.Polymer -> ℂ) : PolymerSystem :=
  { P with activity := z }

/-- Replacing activities does not change the polymer type. -/
instance _root_.YangMills.KP.PolymerSystem.fintype_withActivity
    (P : PolymerSystem) [Fintype P.Polymer] (z : P.Polymer -> ℂ) :
    Fintype (P.withActivity z).Polymer := by
  change Fintype P.Polymer
  infer_instance

/-- The one-complex-parameter family `w * z` used for the disc section. -/
def _root_.YangMills.KP.PolymerSystem.diskFamily
    (P : PolymerSystem) (w : ℂ) : PolymerSystem :=
  P.withActivity fun X => w * P.activity X

section Monotone

variable (P : PolymerSystem) [Fintype P.Polymer]

/-- **Monotonicity of the KP criterion under activity domination.**  The
criterion reads the activity only through `‖z(Y)‖`, so any pointwise
dominated activity inherits the same weight. -/
theorem kpCriterion_withActivity_of_le {a : P.Polymer -> ℝ}
    (hKP : KPCriterion P a) (z : P.Polymer -> ℂ)
    (hz : ∀ X, ‖z X‖ ≤ ‖P.activity X‖) :
    KPCriterion (P.withActivity z) a := by
  obtain ⟨hnn, hsum⟩ := hKP
  refine ⟨hnn, fun X => ?_⟩
  change (∑ Y ∈ (Finset.univ : Finset P.Polymer).filter (fun Y => P.incomp X Y),
      ‖z Y‖ * Real.exp (a Y)) ≤ a X
  refine le_trans (Finset.sum_le_sum fun Y _ => ?_) (hsum X)
  exact mul_le_mul_of_nonneg_right (hz Y) (Real.exp_pos _).le

/-- **The KP zero-free polydisc.**  One KP weight for `P` certifies `Ξ ≠ 0`
for EVERY activity dominated pointwise by that of `P`.  This closes the T0
honesty gap: the criterion is a region statement, not a point statement. -/
theorem partition_withActivity_ne_zero_of_kp {a : P.Polymer -> ℝ}
    (hKP : KPCriterion P a) (z : P.Polymer -> ℂ)
    (hz : ∀ X, ‖z X‖ ≤ ‖P.activity X‖) :
    partition (P.withActivity z) (Finset.univ : Finset P.Polymer) ≠ 0 :=
  partition_ne_zero_of_kp (P.withActivity z)
    (a := a) (kpCriterion_withActivity_of_le P hKP z hz)

/-- Membership of every dominated activity in the repository-level zero-free
region predicate. -/
theorem inKPZeroFreeRegion_withActivity {a : P.Polymer -> ℝ}
    (hKP : KPCriterion P a) (z : P.Polymer -> ℂ)
    (hz : ∀ X, ‖z X‖ ≤ ‖P.activity X‖) :
    InKPZeroFreeRegion (P.withActivity z) :=
  ⟨a, kpCriterion_withActivity_of_le P hKP z hz⟩

/-- **Closed-unit-disc section of the polydisc**: `Ξ(w * z) ≠ 0` for every
`‖w‖ ≤ 1`. -/
theorem partition_diskFamily_ne_zero_of_kp {a : P.Polymer -> ℝ}
    (hKP : KPCriterion P a) {w : ℂ} (hw : ‖w‖ ≤ 1) :
    partition (P.diskFamily w) (Finset.univ : Finset P.Polymer) ≠ 0 := by
  refine partition_withActivity_ne_zero_of_kp P hKP _ fun X => ?_
  rw [norm_mul]
  calc ‖w‖ * ‖P.activity X‖ ≤ 1 * ‖P.activity X‖ :=
        mul_le_mul_of_nonneg_right hw (norm_nonneg _)
    _ = ‖P.activity X‖ := one_mul _

end Monotone

section Analytic

variable (P : PolymerSystem) [Fintype P.Polymer]

/-- The disc section of the partition function is an explicit polynomial in
the fugacity `w`: monomial degree = number of polymers in the admissible
family. -/
theorem partition_diskFamily_eq (w : ℂ) :
    partition (P.diskFamily w) (Finset.univ : Finset P.Polymer)
      = ∑ S ∈ Finset.univ.powerset.filter (Admissible P),
          w ^ S.card * ∏ X ∈ S, P.activity X := by
  show (∑ S ∈ Finset.univ.powerset.filter (Admissible P),
      ∏ X ∈ S, (w * P.activity X)) = _
  refine Finset.sum_congr rfl fun S _ => ?_
  rw [Finset.prod_mul_distrib, Finset.prod_const]

/-- **The disc section is entire.**  Together with
`partition_diskFamily_ne_zero_of_kp` this is the M1 substrate: an analytic,
nonvanishing partition function on the closed unit fugacity disc. -/
theorem analyticOn_partition_diskFamily :
    AnalyticOn ℂ
      (fun w => partition (P.diskFamily w) (Finset.univ : Finset P.Polymer))
      Set.univ := by
  have h : (fun w => partition (P.diskFamily w)
      (Finset.univ : Finset P.Polymer))
      = fun w => ∑ S ∈ Finset.univ.powerset.filter (Admissible P),
          w ^ S.card * ∏ X ∈ S, P.activity X :=
    funext fun w => partition_diskFamily_eq P w
  rw [h]
  exact
    Finset.analyticOn_fun_sum
      (𝕜 := ℂ) (E := ℂ) (F := ℂ)
      (N := Finset.univ.powerset.filter (Admissible P))
      (f := fun S w => w ^ S.card * ∏ X ∈ S, P.activity X)
      (by
        intro S _
        exact ((analyticOn_id : AnalyticOn ℂ (fun w : ℂ => w) Set.univ).pow S.card).mul
          (analyticOn_const :
            AnalyticOn ℂ (fun _ : ℂ => ∏ X ∈ S, P.activity X) Set.univ))

end Analytic

end KP
end LeanZeroFreeRegions
