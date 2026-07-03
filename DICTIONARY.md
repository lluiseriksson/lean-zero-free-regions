# Dictionary: zero-free regions and prime-resolvent analogies

This document is intentionally non-theorematic.  It records analogies only.

## Honest analogy

In analytic number theory, a zero-free region for `ζ(s)` can be converted into
prime-counting estimates by contour shifting and explicit formulae.  In polymer
systems, a zero-free region for a finite-volume partition function can be converted
into a well-defined logarithm, analytic dependence on parameters, and often
correlation estimates.

The shared pattern is:

```text
zero-free region
  -> analytic logarithm / resolvent control
  -> quantitative estimates
```

## What this repo may formalize

- `cluster expansion converges -> partition function nonzero`;
- `analytic logarithm -> zero-free`;
- interfaces for clustering estimates once the model-specific correlation API is
  fixed;
- classical statistical-mechanics root-location case studies.

## What this repo does not claim

- No statement about the Riemann Hypothesis.
- No theorem about zeros of `ζ(s)`.
- No prime number theorem or error term.
- No claim that polymer zero-free machinery implies RH.

The `riemann-prime-resolvent` program remains separate.  This repository only
houses shared formal patterns where the hypotheses are explicit.
