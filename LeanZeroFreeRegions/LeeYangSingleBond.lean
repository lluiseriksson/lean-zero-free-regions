import LeanZeroFreeRegions.LeeYang

/-!
# The single ferromagnetic bond satisfies the Lee-Yang circle theorem

For one ferromagnetic Ising bond the field polynomial is the quadratic
`z^2 + 2 c z + 1` with real `|c| ≤ 1` (concretely `c = e^{-2K}` at coupling
`K ≥ 0`).  Its zeros lie on the unit circle: this file proves it by pure
conjugation algebra (no quadratic formula), discharging the repository's
`LeeYangCircleHypothesis` for the first time, and proves the tensorization
step 0: the class of unit-circle polynomials is closed under products.

References: Lee and Yang (1952), Physical Review 87, 410, Section III (the
two-spin case); Asano (1970), J. Phys. Soc. Japan 29, 350 (contractions and
products).
-/

namespace LeanZeroFreeRegions

open Polynomial
open scoped ComplexConjugate

/-- Unit-circle zero location is preserved by polynomial products: the
degree-zero tensorization step of the Asano route to M2. -/
theorem AllZerosOnUnitCircle.mul {p q : Polynomial ℂ}
    (hp : AllZerosOnUnitCircle p) (hq : AllZerosOnUnitCircle q) :
    AllZerosOnUnitCircle (p * q) := by
  intro z hz
  rw [Polynomial.eval_mul, mul_eq_zero] at hz
  rcases hz with h | h
  · exact hp z h
  · exact hq z h

/-- The single-bond ferromagnetic field polynomial `z^2 + 2 c z + 1`. -/
noncomputable def singleBondPolynomial (c : ℝ) : Polynomial ℂ :=
  Polynomial.X ^ 2 + Polynomial.C ((2 * c : ℝ) : ℂ) * Polynomial.X + 1

/-- **The single-bond Lee-Yang theorem.**  For real `|c| ≤ 1`, every complex
zero of `z^2 + 2 c z + 1` lies on the unit circle.  Proof by conjugation
algebra: `z` and `conj z` are both roots, so either `z + conj z = -2c` (and
then the original equation forces `z * conj z = 1`), or `z` is real (and then
`(x + c)^2 = c^2 - 1 ≤ 0` forces `x = -c`, `c^2 = 1`). -/
theorem allZerosOnUnitCircle_singleBondPolynomial {c : ℝ} (hc : |c| ≤ 1) :
    AllZerosOnUnitCircle (singleBondPolynomial c) := by
  intro z hz
  have hz' : z ^ 2 + ((2 * c : ℝ) : ℂ) * z + 1 = 0 := by
    simpa [singleBondPolynomial, Polynomial.eval_add, Polynomial.eval_mul,
      Polynomial.eval_pow, Polynomial.eval_X, Polynomial.eval_C,
      Polynomial.eval_one] using hz
  have hconj : (conj z) ^ 2 + ((2 * c : ℝ) : ℂ) * conj z + 1 = 0 := by
    have h := congrArg (starRingEnd ℂ) hz'
    simpa [map_add, map_mul, map_pow, map_one, map_zero,
      map_ofNat, Complex.conj_ofReal] using h
  have hfactor : (z - conj z) * (z + conj z + ((2 * c : ℝ) : ℂ)) = 0 := by
    linear_combination hz' - hconj
  -- shared closer: from the squared norm to the norm
  have norm_eq_one_of_sq : ∀ r : ℝ, 0 ≤ r → r ^ 2 = 1 → r = 1 := by
    intro r hr hsq
    have h3 : (r - 1) * (r + 1) = 0 := by ring_nf; linarith
    rcases mul_eq_zero.mp h3 with h | h
    · linarith
    · linarith
  rcases mul_eq_zero.mp hfactor with hreal | hsum
  · -- z = conj z: real root, forced to ±1 by |c| ≤ 1
    have hzc : z = conj z := sub_eq_zero.mp hreal
    have him : z.im = 0 := Complex.conj_eq_iff_im.mp hzc.symm
    have hre : z = ((z.re : ℝ) : ℂ) := by
      have h := Complex.re_add_im z
      rw [him] at h
      simpa using h.symm
    set x : ℝ := z.re with hx
    rw [hre] at hz'
    have hxeq : x ^ 2 + 2 * c * x + 1 = 0 := by exact_mod_cast hz'
    have hcsq : c ^ 2 ≤ 1 := by
      have h := abs_le.mp hc
      nlinarith [h.1, h.2]
    have hsq0 : (x + c) ^ 2 = c ^ 2 - 1 := by linear_combination hxeq
    have hzero : (x + c) ^ 2 = 0 :=
      le_antisymm (by rw [hsq0]; linarith) (sq_nonneg _)
    have hxc : x = -c := by
      have h := (pow_eq_zero_iff two_ne_zero).mp hzero
      linarith
    have hc1 : c ^ 2 = 1 := by
      rw [hzero] at hsq0
      linarith
    have hxx : x ^ 2 = 1 := by rw [hxc, neg_sq]; exact hc1
    have hnorm : ‖z‖ = |x| := by
      rw [hre]
      rw [Complex.norm_real, Real.norm_eq_abs]
    rw [hnorm]
    refine norm_eq_one_of_sq |x| (abs_nonneg x) ?_
    rw [sq_abs]
    exact hxx
  · -- z + conj z = -2c: the original equation forces z * conj z = 1
    have hzz : z * conj z = 1 := by
      linear_combination z * hsum - hz'
    have hnorm2 : ‖z‖ * ‖z‖ = 1 := by
      have h := congrArg norm hzz
      rwa [norm_mul, Complex.norm_conj, norm_one] at h
    refine norm_eq_one_of_sq ‖z‖ (norm_nonneg z) ?_
    rw [pow_two]
    exact hnorm2

/-- The single ferromagnetic bond as a repository-level Ising instance. -/
noncomputable def singleBondInstance (c : ℝ) : FerromagneticIsingInstance :=
  ⟨singleBondPolynomial c⟩

/-- **First discharged Lee-Yang hypothesis of the repository**: the M2
interface record is a theorem for the single ferromagnetic bond. -/
theorem leeYangCircleHypothesis_singleBond {c : ℝ} (hc : |c| ≤ 1) :
    LeeYangCircleHypothesis (singleBondInstance c) :=
  ⟨allZerosOnUnitCircle_singleBondPolynomial hc⟩

end LeanZeroFreeRegions
