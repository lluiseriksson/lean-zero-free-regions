# Hypothesis Frontier

Last updated: 2026-07-03.

## Lean frontier

- `sorry`: 0 in this repository.
- `admit`: 0 in this repository.
- project `axiom`: 0 in this repository.

The no-frontier check is `scripts/check_no_sorry.ps1`.

## Explicit hypotheses currently carried

- `YangMills.KP.KPCriterion P a` in M0.
  - Status: imported from the mother repository.
  - Use: proves `partition P univ ≠ 0` through
    `YangMills.KP.partition_eq_exp_clusterSum_of_kp`.
- `AnalyticLogPartitionHypothesis Ω Z logZ` in M1.
  - Status: explicit hypothesis.
  - Meaning: `logZ` is analytic on `Ω` and `Z = exp logZ` there.
- `TruncatedCorrelationDecay` in M1.
  - Status: explicit hypothesis.
  - Meaning: placeholder for the model-specific truncated-correlation decay
    statement until the correlation API is fixed.
- `LeeYangCircleHypothesis I` in M2.
  - Status: explicit hypothesis.
  - Meaning: all zeros of the finite Ising field polynomial lie on the unit
    circle.  A future Asano/Lieb-Sokal formalization must construct this record.
- `HeilmannLiebHypothesis M` in M3.
  - Status: explicit hypothesis.
  - Meaning: all zeros of the matching polynomial are real and nonpositive.
    A future graph-polynomial formalization must construct this record.

## Distance to the stated objective

M0 is a real theorem for finite polymer systems under the mother repository's
KP criterion.  The remaining bridge from a user-facing "polydisc of convergence"
to `KPCriterion` is still an interface question: this repo currently treats the
KP criterion itself as the convergence-domain certificate.

M1-M3 are honest statement-first interfaces.  They do not prove analytic
continuation, correlation decay, Lee-Yang, or Heilmann-Lieb.  Those results remain
named explicit hypotheses until formal proofs are added.

M4 is documentation only and contains no RH claim.
