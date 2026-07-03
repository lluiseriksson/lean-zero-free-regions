# lean-zero-free-regions

Satellite Lean 4 repository for zero-free-region consequences of convergent
polymer/cluster expansions.  This repo is an external consumer of the
Kotecky-Preiss layer in
[`THE-ERIKSSON-PROGRAMME`](https://github.com/lluiseriksson/THE-ERIKSSON-PROGRAMME).

## Scope disclaimer

This repository formalizes shared zero-free machinery:

- convergent cluster expansion implies nonvanishing finite-volume partition function;
- interfaces for analytic logarithms and truncated-correlation clustering;
- statement-first interfaces for Lee-Yang and Heilmann-Lieb style root-location
  theorems.

This repository does **not** attack the Riemann Hypothesis and makes no claim
toward RH.  The `riemann-prime-resolvent` direction remains a separate program.
Here we only maintain honest shared infrastructure and documentation of analogies.

## Current status

- **M0:** proved for finite polymer systems satisfying the mother repository's
  `YangMills.KP.KPCriterion`.
- **M1:** interface only; analyticity and clustering remain explicit hypotheses.
- **M2:** statement-first interface only; Asano/Lieb-Sokal proof is not formalized.
- **M3:** statement-first interface only; Heilmann-Lieb proof is not formalized.
- **M4:** documentation-only dictionary, with no RH claims.

## Build

```powershell
lake update
lake exe cache get
lake build LeanZeroFreeRegions
powershell -ExecutionPolicy Bypass -File scripts/check_no_sorry.ps1
```

The Lean toolchain and Mathlib revision are pinned to the mother repository:

- Lean: `leanprover/lean4:v4.29.0-rc6`
- Mathlib: `07642720480157414db592fa85b626dafb71355b`
- Mother repository: `THE-ERIKSSON-PROGRAMME`
  at `7a71754b93da6f447544211af51fd513a90b086c`

## Dependency policy

The KP layer is imported as a direct Lake dependency.  No code from the mother
repository is copied into this repo.  API friction should be reported upstream.

Local note: on Windows, `lake exe cache get` is needed before the first build so
ProofWidgets provides its cached JS artifacts.

## Main import

Downstream users should import:

```lean
import LeanZeroFreeRegions.Interfaces
```

Breaking signature changes must be reflected in `INTERFACES.md`.
