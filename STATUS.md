# Status

Last satellite check: 2026-07-04T07:24:52Z.

Checked HEAD: `33c3bd48f8e450a1c69834e70d42846c70b4f030`
(`Expose KP polydisc interfaces`).

Remote health at check time:

- `CI` on `main` for this HEAD: success
  ([run 28698378492](https://github.com/lluiseriksson/lean-zero-free-regions/actions/runs/28698378492)).
- `heartbeat` on `main` for this HEAD: success
  ([run 28698887300](https://github.com/lluiseriksson/lean-zero-free-regions/actions/runs/28698887300)).

## Mother-facing digest

Downstream import:

```lean
import LeanZeroFreeRegions.Interfaces
```

Exact stable names currently exported:

- `LeanZeroFreeRegions.Interfaces.zero_free_of_kp`
- `LeanZeroFreeRegions.Interfaces.zero_free_polydisc_of_kp`
- `LeanZeroFreeRegions.Interfaces.zero_free_unit_fugacity_disc_of_kp`
- `LeanZeroFreeRegions.Interfaces.analyticOn_partition_unit_fugacity_section`
- `LeanZeroFreeRegions.Interfaces.analytic_clustering_package`
- `LeanZeroFreeRegions.Interfaces.lee_yang_circle_of_hypothesis`
- `LeanZeroFreeRegions.Interfaces.heilmann_lieb_of_hypothesis`

Main hypotheses consumed by the M0/M1-facing surface:

- `YangMills.KP.KPCriterion P a`
- `[Fintype P.Polymer]`
- dominated activity hypothesis `hz : forall X, norm (z X) <= norm (P.activity X)`
- unit fugacity hypothesis `hw : norm w <= 1`
- explicit analytic-log hypothesis
  `LeanZeroFreeRegions.AnalyticLogPartitionHypothesis Omega Z logZ`
- explicit clustering hypothesis
  `LeanZeroFreeRegions.TruncatedCorrelationDecay`

Useful source files:

- `LeanZeroFreeRegions/Interfaces.lean`: stable downstream import surface.
- `LeanZeroFreeRegions/Polydisc.lean`: KP monotonicity, polydisc
  nonvanishing, and one-parameter analytic section.
- `INTERFACES.md`: signature contract and breaking-change policy.

Next exact consumer step: import `LeanZeroFreeRegions.Interfaces` from the
mother repository and use `zero_free_polydisc_of_kp` or
`zero_free_unit_fugacity_disc_of_kp` only under an existing
`YangMills.KP.KPCriterion P a`; keep analytic-log and clustering claims behind
their explicit M1 hypotheses.
