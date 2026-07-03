import LeanZeroFreeRegions.ZeroFree
import LeanZeroFreeRegions.AnalyticClustering
import LeanZeroFreeRegions.LeeYang
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

/-- Stable M3 interface: Heilmann-Lieb root-location conclusion from explicit
theorem hypothesis. -/
theorem heilmann_lieb_of_hypothesis (M : MatchingPolynomialInstance)
    (h : HeilmannLiebHypothesis M) :
    AllZerosRealNonpositive M.matchingPolynomial :=
  heilmann_lieb_matching_polynomial M h

end Interfaces
end LeanZeroFreeRegions
