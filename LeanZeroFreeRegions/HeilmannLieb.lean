import Mathlib

/-!
# M3 interface: Heilmann-Lieb matching polynomial

The matching-polynomial theorem is kept as an explicit hypothesis until the graph
and polynomial API choices are fixed.
-/

namespace LeanZeroFreeRegions

/-- Minimal matching-polynomial instance as seen by this satellite. -/
structure MatchingPolynomialInstance where
  /-- The matching polynomial, encoded over complex coefficients for root location. -/
  matchingPolynomial : Polynomial ℂ

/-- Every zero is real and nonpositive. -/
def AllZerosRealNonpositive (p : Polynomial ℂ) : Prop :=
  ∀ z : ℂ, Polynomial.eval z p = 0 → z.im = 0 ∧ z.re ≤ 0

/-- Explicit hypothesis record for the Heilmann-Lieb matching-polynomial theorem.

Reference target: Heilmann and Lieb (1972), Theorem 4.2. -/
structure HeilmannLiebHypothesis (M : MatchingPolynomialInstance) : Prop where
  roots_real_nonpositive : AllZerosRealNonpositive M.matchingPolynomial

/-- **M3 statement-first interface.**  A future graph-theoretic proof should
construct `HeilmannLiebHypothesis`; until then it remains an explicit argument.

Reference target: Heilmann and Lieb (1972), Theorem 4.2. -/
theorem heilmann_lieb_matching_polynomial (M : MatchingPolynomialInstance)
    (h : HeilmannLiebHypothesis M) :
    AllZerosRealNonpositive M.matchingPolynomial :=
  h.roots_real_nonpositive

end LeanZeroFreeRegions
