import YangMills.KP.MayerInversion

/-!
# M0: KP convergence gives nonvanishing partition function

This module is the first external consumer of `YangMills.KP`.  It proves the
finite-volume zero-free consequence directly from the mother repository's
Mayer-Ursell inversion theorem.
-/

namespace LeanZeroFreeRegions
namespace KP

open scoped Classical
open YangMills.KP

/-- The finite-volume KP zero-free region, represented honestly as the existence
of a Kotecky-Preiss weight satisfying the mother repository's criterion.

Reference: Dobrushin (1996), Kotecky-Preiss (1986), Sokal (2001), in the standard
form "convergent polymer expansion gives a nonzero partition function". -/
def InKPZeroFreeRegion (P : PolymerSystem) [Fintype P.Polymer] : Prop :=
  ∃ a : P.Polymer → ℝ, KPCriterion P a

/-- If a finite polymer partition function is represented as the exponential of
its cluster sum, then it is nonzero.

Reference: Sokal (2001), Proposition 2.1: a convergent logarithm/cluster expansion
is a zero-free certificate for the finite-volume partition function. -/
theorem partition_ne_zero_of_cluster_expansion (P : PolymerSystem) [Fintype P.Polymer]
    (hExp :
      partition P (Finset.univ : Finset P.Polymer) = Complex.exp (clusterSum P)) :
    partition P (Finset.univ : Finset P.Polymer) ≠ 0 := by
  rw [hExp]
  exact Complex.exp_ne_zero _

/-- **M0.** Under the mother repository's Kotecky-Preiss criterion, the
finite-volume partition function is nonzero.

This is the current rigorous bridge:
`KPCriterion` supplies convergence, `YangMills.KP.partition_eq_exp_clusterSum_of_kp`
supplies the Mayer-Ursell exponential representation, and `exp z ≠ 0` gives
nonvanishing.  No additional hypothesis is hidden.

Reference: Kotecky and Preiss (1986), Dobrushin (1996), Sokal (2001). -/
theorem partition_ne_zero_of_kp (P : PolymerSystem) [Fintype P.Polymer]
    {a : P.Polymer → ℝ} (hKP : KPCriterion P a) :
    partition P (Finset.univ : Finset P.Polymer) ≠ 0 :=
  partition_ne_zero_of_cluster_expansion P
    (YangMills.KP.partition_eq_exp_clusterSum_of_kp P hKP)

/-- A packaged M0 corollary using the repository-level zero-free-region predicate. -/
theorem partition_ne_zero_of_mem_kp_zero_free_region (P : PolymerSystem)
    [Fintype P.Polymer] (h : InKPZeroFreeRegion P) :
    partition P (Finset.univ : Finset P.Polymer) ≠ 0 := by
  rcases h with ⟨a, hKP⟩
  exact partition_ne_zero_of_kp P (a := a) hKP

end KP
end LeanZeroFreeRegions
