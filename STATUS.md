# Status

Last satellite check: 2026-07-06T08:05:00Z.

Checked HEAD: `d40551bc19b4afab87988fb15264138096b740d4`
(`Merge pull request #28 from lluiseriksson/codex/update-status-head-211077e`).

Remote health at check time:

- `CI` on `main` for this HEAD: success
  ([run 28773377374](https://github.com/lluiseriksson/lean-zero-free-regions/actions/runs/28773377374)).
- `heartbeat` on `main` for this HEAD: success
  ([run 28773376548](https://github.com/lluiseriksson/lean-zero-free-regions/actions/runs/28773376548)).

Most recent merged satellite PR:

- [#28](https://github.com/lluiseriksson/lean-zero-free-regions/pull/28)
  refreshed this mother-facing digest after the unit-fugacity
  polynomial-section interface landed.

This check exposes a small composable M0 wrapper for the unit-fugacity section:
membership in the packaged KP zero-free-region predicate follows from the same
KP certificate and `‖w‖ ≤ 1`. No existing interface name or signature changed,
and no new mathematical claim is introduced.

## Mother-facing digest

Downstream import:

```lean
import LeanZeroFreeRegions.Interfaces
```

Exact stable names currently exported:

- `LeanZeroFreeRegions.Interfaces.kp_zero_free_region`
- `LeanZeroFreeRegions.Interfaces.zero_free_of_kp`
- `LeanZeroFreeRegions.Interfaces.zero_free_of_mem_kp_zero_free_region`
- `LeanZeroFreeRegions.Interfaces.zero_free_polydisc_of_kp`
- `LeanZeroFreeRegions.Interfaces.dominated_activity_mem_kp_zero_free_region`
- `LeanZeroFreeRegions.Interfaces.unit_fugacity_mem_kp_zero_free_region`
- `LeanZeroFreeRegions.Interfaces.zero_free_unit_fugacity_disc_of_kp`
- `LeanZeroFreeRegions.Interfaces.analyticOn_partition_unit_fugacity_section`
- `LeanZeroFreeRegions.Interfaces.partition_unit_fugacity_section_eq`
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
- packaged M0 membership
  `LeanZeroFreeRegions.Interfaces.kp_zero_free_region P`
- `[Fintype P.Polymer]`
- dominated activity hypothesis `hz : forall X, norm (z X) <= norm (P.activity X)`
- unit fugacity hypothesis `hw : norm w <= 1`
- packaged unit-fugacity membership
  `LeanZeroFreeRegions.Interfaces.unit_fugacity_mem_kp_zero_free_region P hKP hw`
- explicit polynomial-section identity
  `LeanZeroFreeRegions.Interfaces.partition_unit_fugacity_section_eq P w`
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
mother repository and smoke-test
`unit_fugacity_mem_kp_zero_free_region P hKP hw`, then consume the returned
membership with `zero_free_of_mem_kp_zero_free_region (P.diskFamily w) h`; keep
`partition_unit_fugacity_section_eq P w` as the exact polynomial oracle for the
one-parameter fugacity section, keep
`dominated_activity_mem_kp_zero_free_region P hKP z hz` followed by
`zero_free_of_mem_kp_zero_free_region (P.withActivity z) h` as the dominated
M0 nonvanishing smoke test, keep `two_single_bond_product_circle` as the
current M2 smoke test under separate hypotheses `hc1 : |c1| <= 1` and
`hc2 : |c2| <= 1`, and keep analytic-log and clustering claims behind their
explicit M1 hypotheses.
