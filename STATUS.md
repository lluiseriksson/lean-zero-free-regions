# Status

Last satellite check: 2026-07-07T06:03:54Z.

Checked HEAD: `b0b3f2b73ed0207d7818b86f87453120bc447781`
(`update status for 86b039f main (#42)`).

Remote health at check time:

- `CI` on `main` for this HEAD: success
  ([run 28843612392](https://github.com/lluiseriksson/lean-zero-free-regions/actions/runs/28843612392)).
- `heartbeat` on `main` for this HEAD: success
  ([run 28843612388](https://github.com/lluiseriksson/lean-zero-free-regions/actions/runs/28843612388)).

Most recent merged satellite PR:

- [#42](https://github.com/lluiseriksson/lean-zero-free-regions/pull/42)
  refreshed this status digest after PR #41 landed.

Candidate PR from this check adds a small M0 endpoint smoke-test interface:
`zero_fugacity_mem_kp_zero_free_region` packages `P.diskFamily 0` in
`kp_zero_free_region`, and `zero_free_zero_fugacity_of_kp` exposes the
corresponding nonvanishing partition function. Both are direct specializations
of the existing unit-fugacity disc interface with `w = 0`; no analytic
logarithm, clustering, or frontier theorem is asserted.

## Mother-facing digest

Downstream import:

```lean
import LeanZeroFreeRegions.Interfaces
```

Exact stable names currently exported:

- `LeanZeroFreeRegions.Interfaces.kp_zero_free_region`
- `LeanZeroFreeRegions.Interfaces.mem_kp_zero_free_region_of_kp`
- `LeanZeroFreeRegions.Interfaces.zero_free_of_kp`
- `LeanZeroFreeRegions.Interfaces.kpCriterion_of_dominated_activity`
- `LeanZeroFreeRegions.Interfaces.zero_free_of_mem_kp_zero_free_region`
- `LeanZeroFreeRegions.Interfaces.zero_free_polydisc_of_kp`
- `LeanZeroFreeRegions.Interfaces.dominated_activity_mem_kp_zero_free_region`
- `LeanZeroFreeRegions.Interfaces.unit_fugacity_mem_kp_zero_free_region`
- `LeanZeroFreeRegions.Interfaces.zero_fugacity_mem_kp_zero_free_region`
- `LeanZeroFreeRegions.Interfaces.zero_free_unit_fugacity_disc_of_kp`
- `LeanZeroFreeRegions.Interfaces.zero_free_zero_fugacity_of_kp`
- `LeanZeroFreeRegions.Interfaces.analyticOn_partition_unit_fugacity_section`
- `LeanZeroFreeRegions.Interfaces.partition_unit_fugacity_section_eq`
- `LeanZeroFreeRegions.Interfaces.zero_free_of_analytic_log_partition`
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
- direct packaged-region wrapper
  `LeanZeroFreeRegions.Interfaces.mem_kp_zero_free_region_of_kp P hKP`
- dominated activity criterion wrapper
  `LeanZeroFreeRegions.Interfaces.kpCriterion_of_dominated_activity P hKP z hz`
- packaged M0 membership
  `LeanZeroFreeRegions.Interfaces.kp_zero_free_region P`
- `[Fintype P.Polymer]`
- dominated activity hypothesis `hz : forall X, norm (z X) <= norm (P.activity X)`
- unit fugacity hypothesis `hw : norm w <= 1`
- packaged unit-fugacity membership
  `LeanZeroFreeRegions.Interfaces.unit_fugacity_mem_kp_zero_free_region P hKP hw`
- zero-fugacity endpoint membership
  `LeanZeroFreeRegions.Interfaces.zero_fugacity_mem_kp_zero_free_region P hKP`
- explicit polynomial-section identity
  `LeanZeroFreeRegions.Interfaces.partition_unit_fugacity_section_eq P w`
- explicit analytic-log hypothesis
  `LeanZeroFreeRegions.AnalyticLogPartitionHypothesis Omega Z logZ`
- direct M1 zero-free wrapper
  `LeanZeroFreeRegions.Interfaces.zero_free_of_analytic_log_partition hAnalytic`
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
`mem_kp_zero_free_region_of_kp P hKP` when the downstream wants the packaged
M0 predicate directly from a KP criterion; keep
`kpCriterion_of_dominated_activity P hKP z hz` when the downstream wants to
reuse the original KP weight `a` after replacing activities by a pointwise
dominated `z`; keep `unit_fugacity_mem_kp_zero_free_region P hKP hw`, then
consume the returned membership with
`zero_free_of_mem_kp_zero_free_region (P.diskFamily w) h`; keep
`zero_fugacity_mem_kp_zero_free_region P hKP` and
`zero_free_zero_fugacity_of_kp P hKP` as the exact endpoint smoke tests for
`P.diskFamily 0`; keep
`partition_unit_fugacity_section_eq P w` as the exact polynomial oracle for the
one-parameter fugacity section, keep
`dominated_activity_mem_kp_zero_free_region P hKP z hz` followed by
`zero_free_of_mem_kp_zero_free_region (P.withActivity z) h` as the dominated
M0 nonvanishing smoke test, keep
`zero_free_of_analytic_log_partition hAnalytic z hzOmega` when the downstream
already has an explicit analytic-log hypothesis and only needs nonvanishing,
keep `two_single_bond_product_circle` as the current M2 smoke test under
separate hypotheses `hc1 : |c1| <= 1` and `hc2 : |c2| <= 1`, and keep
analytic-log and clustering claims behind their explicit M1 hypotheses.
