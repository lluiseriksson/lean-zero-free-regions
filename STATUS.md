# Status

Last satellite check: 2026-07-06T09:56:46Z.

Checked HEAD: `bbca62bf43133571a1a62d8fa889889d5dbe0453`
(`update status for 3dca6ae main (#30)`).

Remote health at check time:

- `CI` on `main` for this HEAD: success
  ([run 28780079936](https://github.com/lluiseriksson/lean-zero-free-regions/actions/runs/28780079936)).
- `heartbeat` on `main` for this HEAD: success
  ([run 28780700009](https://github.com/lluiseriksson/lean-zero-free-regions/actions/runs/28780700009)).

Most recent merged satellite PR:

- [#30](https://github.com/lluiseriksson/lean-zero-free-regions/pull/30)
  refreshed this status digest after
  `unit_fugacity_mem_kp_zero_free_region` landed.

This branch exposes a small composable M0 wrapper for KP monotonicity:
`kpCriterion_of_dominated_activity` reuses the same KP weight for any
pointwise dominated activity. No existing interface name or signature changed,
and no new mathematical claim is introduced.

## Mother-facing digest

Downstream import:

```lean
import LeanZeroFreeRegions.Interfaces
```

Exact stable names currently exported:

- `LeanZeroFreeRegions.Interfaces.kp_zero_free_region`
- `LeanZeroFreeRegions.Interfaces.zero_free_of_kp`
- `LeanZeroFreeRegions.Interfaces.kpCriterion_of_dominated_activity`
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
- dominated activity criterion wrapper
  `LeanZeroFreeRegions.Interfaces.kpCriterion_of_dominated_activity P hKP z hz`
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
`kpCriterion_of_dominated_activity P hKP z hz` when the downstream wants to
reuse the original KP weight `a` after replacing activities by a pointwise
dominated `z`; keep `unit_fugacity_mem_kp_zero_free_region P hKP hw`, then
consume the returned membership with
`zero_free_of_mem_kp_zero_free_region (P.diskFamily w) h`; keep
`partition_unit_fugacity_section_eq P w` as the exact polynomial oracle for the
one-parameter fugacity section, keep
`dominated_activity_mem_kp_zero_free_region P hKP z hz` followed by
`zero_free_of_mem_kp_zero_free_region (P.withActivity z) h` as the dominated
M0 nonvanishing smoke test, keep `two_single_bond_product_circle` as the
current M2 smoke test under separate hypotheses `hc1 : |c1| <= 1` and
`hc2 : |c2| <= 1`, and keep analytic-log and clustering claims behind their
explicit M1 hypotheses.
