# Legacy samples

Historical sample source collected between 2020 and 2026, kept for **visual inspection only**. Nothing in this directory is run by any test.
- `general/` - ad-hoc samples written while the grammars were being developed.
- `issues/` - one sample per reported GitHub issue, named `<issue-number>.<ext>`.

These files are **not warranted to be valid IBM i source**. 
Some were written from memory rather than from documentation, and at least one is known to be 
invalid: `general/test-fullfree.rpgle` opens with `**FREE`, which declares a
fully free-form member, then contains columnar fixed-format H-specs, which such a member cannot hold.

They remain useful for two things:

1. **Eyeballing a change.** Open one in the Extension Development Host to see how a grammar edit looks against realistic source.
2. **Mining edge cases.** `issues/` in particular records constructs that genuinely broke highlighting for real users - the best available source of cases worth covering.

When a case here is worth protecting, promote it into a real fixture under `tests/fixtures/`, and note the originating issue number in the fixture header
so the provenance survives.

Verified fixtures live in `tests/fixtures/`. That is the only directory under test.
