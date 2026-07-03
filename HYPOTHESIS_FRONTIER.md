# Hypothesis Frontier

Date: 2026-07-03 (second iteration)

## Main branch status

- Lean `sorry`: 0. Project `axiom`: 0.
- Direct dependency: `YangMills` (mother) at `7a71754b93da6f447544211af51fd513a90b086c`; no KP code copied.

## Closed facts on `main`

M0 (previous iteration): `KPCriterion P a -> partition P univ ≠ 0` via the
mother's `partition_eq_exp_clusterSum_of_kp`.

Polydisc layer (`Polydisc.lean`) — the T0 honesty gap CLOSED:

- `PolymerSystem.withActivity`, `PolymerSystem.diskFamily`.
- `kpCriterion_withActivity_of_le`: the KP criterion is monotone under
  pointwise activity domination (it reads activities only through norms).
- `partition_withActivity_ne_zero_of_kp`: **the KP zero-free polydisc** —
  one KP weight certifies Z ≠ 0 for EVERY pointwise-dominated activity.
  The "convergence polydisc" is now a theorem, not a phrase.
- `partition_diskFamily_ne_zero_of_kp`: closed-unit-disc fugacity section.
- `partition_diskFamily_eq` and `analyticOn_partition_diskFamily`: the disc
  section is an explicit polynomial in the fugacity, hence entire — the M1
  substrate (analytic + zero-free on the disc).

Lee-Yang layer (`LeeYangSingleBond.lean`) — first M2 content:

- `AllZerosOnUnitCircle.mul`: product closure (tensorization step 0).
- `allZerosOnUnitCircle_singleBondPolynomial`: the single ferromagnetic bond
  polynomial `z^2 + 2cz + 1`, real `|c| ≤ 1`, has all zeros on the unit
  circle (pure conjugation algebra; no quadratic formula).
- `leeYangCircleHypothesis_singleBond`: **first discharged
  `LeeYangCircleHypothesis`** of the repository.

Dictionary companion (`Dictionary.lean`, DROPPABLE ON REVIEW):

- `riemannZeta_zero_free_of_absolute_convergence`: verbatim re-export of
  Mathlib's `riemannZeta_ne_zero_of_one_lt_re`, recorded only so
  DICTIONARY.md can cite both sides of the "absolute convergence ⇒
  zero-free" pattern as formal statements. ZERO new claims; nothing about
  `Re s ≤ 1`; delete the file if M4 is read as documentation-only.

## Frontier obligations (branch `frontier/M1-M2`, statement-first, sorried)

Current frontier branch status: exactly 3 Lean `sorry`, all in
`Frontier/AnalyticLog.lean`; project `axiom`: 0.  This branch is not a
candidate for `main`.  On this branch only, `LeanZeroFreeRegions.lean`
imports the frontier module so CI builds these statements.

`Frontier/AnalyticLog.lean`:

- `exists_analyticLog_on_disk` (M1: analytic log on the open fugacity disc;
  route: simple connectivity + the entire nonvanishing section on `main`).
- `analyticLog_eq_clusterSum_at_one` (ties the disc logarithm to the
  mother's `clusterSum`).
- `asano_contraction` (M2 induction step, Asano 1970 in Ruelle's
  multi-affine form; the base case is already a theorem on `main`).

## Honest distance to the goal

M0 is now a region statement.  M1 has its two ingredients (analytic +
zero-free on the disc) proved and awaits only the logarithm construction.
M2 has base case and product closure proved, and its induction step stated.
M3 (Heilmann-Lieb) untouched.  M4 remains documentation (plus the droppable
verbatim re-export).  No statement about RH anywhere, as per DICTIONARY.md.
