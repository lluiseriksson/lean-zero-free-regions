import Mathlib

/-!
# M2 interface: Lee-Yang circle theorem

The proof route is intentionally an explicit hypothesis until Asano contractions
or a Lieb-Sokal proof are formalized.
-/

namespace LeanZeroFreeRegions

open Polynomial

/-- Minimal finite ferromagnetic Ising instance as seen by this satellite:
the object exported to zero-free machinery is its field polynomial. -/
structure FerromagneticIsingInstance where
  /-- Field/activity polynomial whose zeros are governed by Lee-Yang. -/
  fieldPolynomial : Polynomial ℂ

/-- All complex zeros of a polynomial lie on the unit circle. -/
def AllZerosOnUnitCircle (p : Polynomial ℂ) : Prop :=
  ∀ z : ℂ, Polynomial.eval z p = 0 → ‖z‖ = 1

/-- Explicit hypothesis record for the Lee-Yang circle theorem.

Reference target: Lee and Yang (1952), Asano (1970), Lieb and Sokal (1981). -/
structure LeeYangCircleHypothesis (I : FerromagneticIsingInstance) : Prop where
  roots_on_unit_circle : AllZerosOnUnitCircle I.fieldPolynomial

/-- **M2 statement-first interface.**  A formal Asano/Lieb-Sokal proof should
eventually construct `LeeYangCircleHypothesis`; until then it remains an explicit
argument.

Reference target: Lee and Yang (1952), Asano (1970), Lieb and Sokal (1981). -/
theorem lee_yang_circle (I : FerromagneticIsingInstance)
    (h : LeeYangCircleHypothesis I) :
    AllZerosOnUnitCircle I.fieldPolynomial :=
  h.roots_on_unit_circle

end LeanZeroFreeRegions
