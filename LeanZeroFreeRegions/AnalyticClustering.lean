import Mathlib

/-!
# M1 interface: zero-free, analytic log, and clustering

This file contains only honest implication-level infrastructure.  Analyticity and
clustering estimates not yet proved in this repository are explicit hypotheses.
-/

namespace LeanZeroFreeRegions

open scoped Classical

/-- An explicitly supplied analytic logarithm of a partition function on a domain.

Reference: Sokal (2001), Sections 2-3, where a convergent polymer expansion gives
a holomorphic logarithm and hence a zero-free partition function. -/
structure AnalyticLogPartitionHypothesis (Ω : Set ℂ) (Z logZ : ℂ → ℂ) : Prop where
  /-- The proposed logarithm is analytic on the domain. -/
  logZ_analytic : AnalyticOn ℂ logZ Ω
  /-- The partition function is represented by the exponential of that logarithm. -/
  exp_logZ_eq_partition : ∀ z ∈ Ω, Complex.exp (logZ z) = Z z

/-- A named clustering assertion kept abstract until the correlation API is fixed.

The fields intentionally contain only data and an explicit proposition.  No
clustering theorem is asserted by this definition. -/
structure TruncatedCorrelationDecay where
  /-- The external, model-specific decay statement. -/
  decay_statement : Prop
  /-- Proof of the model-specific decay statement. -/
  decay_proof : decay_statement

/-- The M1 package: zero-free partition function, analytic logarithm, and truncated
correlation decay, all on the same domain. -/
structure ZeroFreeAnalyticClusteringPackage (Ω : Set ℂ) (Z logZ : ℂ → ℂ) where
  zero_free : ∀ z ∈ Ω, Z z ≠ 0
  logZ_analytic : AnalyticOn ℂ logZ Ω
  exp_logZ_eq_partition : ∀ z ∈ Ω, Complex.exp (logZ z) = Z z
  clustering : TruncatedCorrelationDecay

/-- An analytic logarithm immediately implies zero-freeness of the partition
function on the same domain.

Reference: Sokal (2001), Proposition 2.1. -/
theorem zero_free_of_analytic_log_partition {Ω : Set ℂ} {Z logZ : ℂ → ℂ}
    (h : AnalyticLogPartitionHypothesis Ω Z logZ) :
    ∀ z ∈ Ω, Z z ≠ 0 := by
  intro z hz hzero
  have hExp : Complex.exp (logZ z) = 0 := by
    rw [h.exp_logZ_eq_partition z hz, hzero]
  exact Complex.exp_ne_zero (logZ z) hExp

/-- Build the M1 package from explicit analytic-log and clustering hypotheses.

This theorem is intentionally not a proof of clustering from KP; it is the stable
interface for such a proof once the correlation API is imported or developed. -/
def zeroFreeAnalyticClusteringPackage_of_hypotheses {Ω : Set ℂ} {Z logZ : ℂ → ℂ}
    (hAnalytic : AnalyticLogPartitionHypothesis Ω Z logZ)
    (hClustering : TruncatedCorrelationDecay) :
    ZeroFreeAnalyticClusteringPackage Ω Z logZ where
  zero_free := zero_free_of_analytic_log_partition hAnalytic
  logZ_analytic := hAnalytic.logZ_analytic
  exp_logZ_eq_partition := hAnalytic.exp_logZ_eq_partition
  clustering := hClustering

end LeanZeroFreeRegions
