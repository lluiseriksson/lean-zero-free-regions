import LeanZeroFreeRegions.Polydisc
import LeanZeroFreeRegions.AnalyticClustering
import LeanZeroFreeRegions.LeeYang
import LeanZeroFreeRegions.LeeYangSingleBond
import LeanZeroFreeRegions.HeilmannLieb

/-!
# Stable import surface for the mother repository

Import this module from downstream repositories.  Signature changes here are
breaking and must be mirrored in `INTERFACES.md`.
-/

namespace LeanZeroFreeRegions
namespace Interfaces

open scoped Classical
open YangMills.KP

/-- Stable M0 interface: KP criterion implies nonvanishing partition function. -/
theorem zero_free_of_kp (P : PolymerSystem) [Fintype P.Polymer]
    {a : P.Polymer → ℝ} (hKP : KPCriterion P a) :
    partition P (Finset.univ : Finset P.Polymer) ≠ 0 :=
  KP.partition_ne_zero_of_kp P hKP

/-- Stable M0 interface: KP is a zero-free polydisc certificate for every
pointwise dominated activity. -/
theorem zero_free_polydisc_of_kp (P : PolymerSystem) [Fintype P.Polymer]
    {a : P.Polymer → ℝ} (hKP : KPCriterion P a) (z : P.Polymer → ℂ)
    (hz : ∀ X, ‖z X‖ ≤ ‖P.activity X‖) :
    partition (P.withActivity z) (Finset.univ : Finset P.Polymer) ≠ 0 :=
  KP.partition_withActivity_ne_zero_of_kp P hKP z hz

/-- Stable M0 interface: the one-parameter fugacity section is nonvanishing on
the closed unit disc. -/
theorem zero_free_unit_fugacity_disc_of_kp (P : PolymerSystem)
    [Fintype P.Polymer] {a : P.Polymer → ℝ} (hKP : KPCriterion P a)
    {w : ℂ} (hw : ‖w‖ ≤ 1) :
    partition (P.diskFamily w) (Finset.univ : Finset P.Polymer) ≠ 0 :=
  KP.partition_diskFamily_ne_zero_of_kp P hKP hw

/-- Stable M1 substrate interface: the one-parameter fugacity section is an
entire polynomial section. -/
theorem analyticOn_partition_unit_fugacity_section (P : PolymerSystem)
    [Fintype P.Polymer] :
    AnalyticOn ℂ
      (fun w => partition (P.diskFamily w) (Finset.univ : Finset P.Polymer))
      Set.univ :=
  KP.analyticOn_partition_diskFamily P

/-- Stable M1 interface: explicit analytic-log and clustering hypotheses assemble
the zero-free/analytic/clustering package. -/
def analytic_clustering_package {Ω : Set ℂ} {Z logZ : ℂ → ℂ}
    (hAnalytic : AnalyticLogPartitionHypothesis Ω Z logZ)
    (hClustering : TruncatedCorrelationDecay) :
    ZeroFreeAnalyticClusteringPackage Ω Z logZ :=
  zeroFreeAnalyticClusteringPackage_of_hypotheses hAnalytic hClustering

/-- Stable M2 interface: Lee-Yang circle conclusion from explicit theorem
hypothesis. -/
theorem lee_yang_circle_of_hypothesis (I : FerromagneticIsingInstance)
    (h : LeeYangCircleHypothesis I) :
    AllZerosOnUnitCircle I.fieldPolynomial :=
  lee_yang_circle I h

/-- Stable M2 tensorization interface: unit-circle zero location is preserved
under products. -/
theorem all_zeros_on_unit_circle_mul {p q : Polynomial ℂ}
    (hp : AllZerosOnUnitCircle p) (hq : AllZerosOnUnitCircle q) :
    AllZerosOnUnitCircle (p * q) :=
  AllZerosOnUnitCircle.mul hp hq

/-- Stable M2 example interface: the single ferromagnetic-bond field polynomial. -/
noncomputable def single_bond_polynomial (c : ℝ) : Polynomial ℂ :=
  singleBondPolynomial c

/-- Stable M2 example interface: the single ferromagnetic-bond instance. -/
noncomputable def single_bond_instance (c : ℝ) : FerromagneticIsingInstance :=
  singleBondInstance c

/-- Stable M2 example interface: the proved Lee-Yang circle conclusion for one
ferromagnetic bond. -/
theorem lee_yang_single_bond_circle {c : ℝ} (hc : |c| ≤ 1) :
    AllZerosOnUnitCircle (single_bond_polynomial c) := by
  simpa [single_bond_polynomial] using allZerosOnUnitCircle_singleBondPolynomial hc

/-- Stable M2 example interface: the one-bond proof discharges the explicit
Lee-Yang hypothesis record. -/
theorem lee_yang_single_bond_hypothesis {c : ℝ} (hc : |c| ≤ 1) :
    LeeYangCircleHypothesis (single_bond_instance c) := by
  simpa [single_bond_instance] using leeYangCircleHypothesis_singleBond hc

/-- Stable M3 interface: Heilmann-Lieb root-location conclusion from explicit
theorem hypothesis. -/
theorem heilmann_lieb_of_hypothesis (M : MatchingPolynomialInstance)
    (h : HeilmannLiebHypothesis M) :
    AllZerosRealNonpositive M.matchingPolynomial :=
  heilmann_lieb_matching_polynomial M h

end Interfaces
end LeanZeroFreeRegions
