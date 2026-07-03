# Mathlib Audit

Last updated: 2026-07-03.

Pinned Mathlib revision:
`07642720480157414db592fa85b626dafb71355b`.

This audit is intentionally narrow: it records what this repo expects to reuse
before adding local statements.

## Already present or expected in Mathlib

- Complex exponential nonvanishing:
  - Used as `Complex.exp_ne_zero`.
  - Observed at `Mathlib/Analysis/Complex/Exponential.lean`.
  - Consumed in M0 and M1 zero-free consequences.
- Analytic-function vocabulary:
  - Used as `AnalyticOn ℂ f Ω`.
  - Observed at `Mathlib/Analysis/Analytic/Basic.lean`.
  - Consumed only in M1 interface statements.
- Polynomial API:
  - Used as `Polynomial ℂ` and `Polynomial.eval`.
  - Observed at `Mathlib/Algebra/Polynomial/Eval/Defs.lean`.
  - Consumed in M2/M3 statement-first interfaces.
- Finite sums, `Finset.univ`, `Fintype`, and big operators:
  - Used throughout M0 and inherited from `YangMills.KP`.

## Not found as ready-made Mathlib theorems in this audit scope

- Kotecky-Preiss/Dobrushin/Sokal polymer-gas zero-free theorems.
- Lee-Yang circle theorem via Asano contractions or Lieb-Sokal.
- Heilmann-Lieb matching-polynomial root-location theorem.
- A domain-specific "zero-free iff analytic logarithm iff clustering" package for
  statistical mechanics partition functions.

Targeted audit command:

```powershell
rg -n "Kotecky|Kotecký|Dobrushin|Sokal|Lee.?Yang|Heilmann|Asano|matching polynomial|zero.?free|zero_free|ZeroFree" .lake/packages/mathlib/Mathlib -g "*.lean"
```

Result on the pinned checkout: no matches for these project-specific theorem
families.

## Upstream candidates

- General lemma: if `Z = exp logZ` on a set, then `Z` is zero-free there.
- General packaging lemmas connecting analytic logarithms and zero-free functions,
  if not already present under a more idiomatic Mathlib name.
- Polynomial root-location predicates for classical theorems, once statements are
  independent of this project's statistical-mechanics vocabulary.

## Follow-up audit commands

After `lake update`, run:

```powershell
rg -n "exp_ne_zero|AnalyticOn|Polynomial.eval|zero.?free|Lee.?Yang|Heilmann|Kotecky|Dobrushin|Sokal" .lake/packages/mathlib/Mathlib -g "*.lean"
```
