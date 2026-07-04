# Interfaces

This file records the exact import surface expected by downstream repositories.
Signature changes are breaking.

Import:

```lean
import LeanZeroFreeRegions.Interfaces
```

## M0

```lean
theorem LeanZeroFreeRegions.Interfaces.zero_free_of_kp
    (P : YangMills.KP.PolymerSystem) [Fintype P.Polymer]
    {a : P.Polymer → ℝ} (hKP : YangMills.KP.KPCriterion P a) :
    YangMills.KP.partition P (Finset.univ : Finset P.Polymer) ≠ 0
```

```lean
theorem LeanZeroFreeRegions.Interfaces.zero_free_polydisc_of_kp
    (P : YangMills.KP.PolymerSystem) [Fintype P.Polymer]
    {a : P.Polymer → ℝ} (hKP : YangMills.KP.KPCriterion P a)
    (z : P.Polymer → ℂ)
    (hz : ∀ X, ‖z X‖ ≤ ‖P.activity X‖) :
    YangMills.KP.partition (P.withActivity z)
      (Finset.univ : Finset P.Polymer) ≠ 0
```

```lean
theorem LeanZeroFreeRegions.Interfaces.zero_free_unit_fugacity_disc_of_kp
    (P : YangMills.KP.PolymerSystem) [Fintype P.Polymer]
    {a : P.Polymer → ℝ} (hKP : YangMills.KP.KPCriterion P a)
    {w : ℂ} (hw : ‖w‖ ≤ 1) :
    YangMills.KP.partition (P.diskFamily w)
      (Finset.univ : Finset P.Polymer) ≠ 0
```

```lean
theorem LeanZeroFreeRegions.Interfaces.analyticOn_partition_unit_fugacity_section
    (P : YangMills.KP.PolymerSystem) [Fintype P.Polymer] :
    AnalyticOn ℂ
      (fun w => YangMills.KP.partition (P.diskFamily w)
        (Finset.univ : Finset P.Polymer))
      Set.univ
```

## M1

```lean
def LeanZeroFreeRegions.Interfaces.analytic_clustering_package
    {Ω : Set ℂ} {Z logZ : ℂ → ℂ}
    (hAnalytic : LeanZeroFreeRegions.AnalyticLogPartitionHypothesis Ω Z logZ)
    (hClustering : LeanZeroFreeRegions.TruncatedCorrelationDecay) :
    LeanZeroFreeRegions.ZeroFreeAnalyticClusteringPackage Ω Z logZ
```

## M2

```lean
theorem LeanZeroFreeRegions.Interfaces.lee_yang_circle_of_hypothesis
    (I : LeanZeroFreeRegions.FerromagneticIsingInstance)
    (h : LeanZeroFreeRegions.LeeYangCircleHypothesis I) :
    LeanZeroFreeRegions.AllZerosOnUnitCircle I.fieldPolynomial
```

## M3

```lean
theorem LeanZeroFreeRegions.Interfaces.heilmann_lieb_of_hypothesis
    (M : LeanZeroFreeRegions.MatchingPolynomialInstance)
    (h : LeanZeroFreeRegions.HeilmannLiebHypothesis M) :
    LeanZeroFreeRegions.AllZerosRealNonpositive M.matchingPolynomial
```

## Breaking-change policy

Any change to these theorem names, namespace paths, argument order, implicit
arguments, or conclusion types is breaking and must be announced before the mother
repository imports this module.
