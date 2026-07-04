# Status

Last satellite check: 2026-07-04T17:16:01Z.

Checked HEAD: `05f3814f45cb42868a246b7870cea4963512bd22`
(`Merge pull request #10 from lluiseriksson/codex/expose-unit-circle-product-interface`).

Remote health at check time:

- `CI` on `main` for this HEAD: success
  ([run 28712687122](https://github.com/lluiseriksson/lean-zero-free-regions/actions/runs/28712687122)).
- `heartbeat` on `main` for this HEAD: success
  ([run 28712687123](https://github.com/lluiseriksson/lean-zero-free-regions/actions/runs/28712687123)).

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
- `LeanZeroFreeRegions.Interfaces.all_zeros_on_unit_circle_mul`
- `LeanZeroFreeRegions.Interfaces.single_bond_polynomial`
- `LeanZeroFreeRegions.Interfaces.single_bond_instance`
- `LeanZeroFreeRegions.Interfaces.lee_yang_single_bond_circle`
- `LeanZeroFreeRegions.Interfaces.two_single_bond_product_circle`
- `LeanZeroFreeRegions.Interfaces.lee_yang_single_bond_hypothesis`
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
- one-bond M2 hypothesis `hc : |c| <= 1` for
  `LeanZeroFreeRegions.Interfaces.lee_yang_single_bond_circle` and
  `LeanZeroFreeRegions.Interfaces.lee_yang_single_bond_hypothesis`
- two independent one-bond M2 hypotheses `hc1 : |c1| <= 1` and
  `hc2 : |c2| <= 1` for
  `LeanZeroFreeRegions.Interfaces.two_single_bond_product_circle`

Useful source files:

- `LeanZeroFreeRegions/Interfaces.lean`: stable downstream import surface.
- `LeanZeroFreeRegions/Polydisc.lean`: KP monotonicity, polydisc
  nonvanishing, and one-parameter analytic section.
- `LeanZeroFreeRegions/LeeYangSingleBond.lean`: proved one-bond Lee-Yang
  example and product closure helper.
- `INTERFACES.md`: signature contract and breaking-change policy.

Next exact consumer step: import `LeanZeroFreeRegions.Interfaces` from the
mother repository and run a minimal downstream smoke test applying
`two_single_bond_product_circle` for a product of two one-bond polynomials under
separate hypotheses `hc1 : |c1| <= 1` and `hc2 : |c2| <= 1`; use
`zero_free_polydisc_of_kp` or
`zero_free_unit_fugacity_disc_of_kp` only under an existing
`YangMills.KP.KPCriterion P a`, and keep analytic-log and clustering claims
behind their explicit M1 hypotheses.
