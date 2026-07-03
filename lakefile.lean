import Lake
open Lake DSL

package «LeanZeroFreeRegions» where
  -- Satellite repository for zero-free-region consequences of cluster expansions.

-- Pinned to the exact Mathlib revision used by THE-ERIKSSON-PROGRAMME.
require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @
    "07642720480157414db592fa85b626dafb71355b"

-- Direct dependency on the mother repository.  Do not copy KP code locally.
require «YangMills» from git
  "https://github.com/lluiseriksson/THE-ERIKSSON-PROGRAMME.git" @
    "7a71754b93da6f447544211af51fd513a90b086c"

lean_lib «LeanZeroFreeRegions» where
  -- Library modules live under LeanZeroFreeRegions/.

lean_lib «Interfaces» where
  -- Top-level compatibility contract requested by the fleet protocol.
