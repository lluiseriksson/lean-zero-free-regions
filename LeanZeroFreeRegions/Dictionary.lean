import Mathlib

/-!
# Dictionary companion: the absolute-convergence zero-free pattern

DICTIONARY.md records the analogy "absolute convergence gives a zero-free
region" on both sides of the dictionary.  This module makes the two sides
citable next to each other AS EXISTING THEOREMS, without adding any claim:

* polymer side: `LeanZeroFreeRegions.KP.partition_ne_zero_of_kp` (this
  repository, from the mother's KP layer);
* number-theory side: Mathlib's Euler-product nonvanishing of `ζ` on
  `Re s > 1`, re-exported verbatim below.

DROPPABLE ON REVIEW: if the Revisor reads milestone M4 ("dictionary is
documentation only") as excluding even a verbatim Mathlib re-export, delete
this file; nothing depends on it.  It states NOTHING about the Riemann
Hypothesis, the critical strip, or any zero of `ζ` with `Re s ≤ 1`.
-/

namespace LeanZeroFreeRegions
namespace Dictionary

/-- Number-theory side of the dictionary pattern, verbatim from Mathlib: in
the half-plane of absolute convergence of the Euler product, `ζ` has no
zeros.  This is Mathlib's theorem, recorded here only so DICTIONARY.md can
cite both sides of the pattern as formal statements. -/
theorem riemannZeta_zero_free_of_absolute_convergence {s : ℂ}
    (hs : 1 < s.re) : riemannZeta s ≠ 0 :=
  riemannZeta_ne_zero_of_one_lt_re hs

end Dictionary
end LeanZeroFreeRegions
