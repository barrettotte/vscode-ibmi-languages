# Releasing

A release is cut by publishing a GitHub release. The [release workflow](../.github/workflows/release.yml) does the rest: it runs the
same checks CI runs, packages the extension once, attaches that `.vsix` to the release, and publishes it to both marketplaces.

## Steps

1. **Bump the version in `package.json` _and_ `package-lock.json`.**

   The lock file records the package's own version in two places, and `npm run lint` fails if either disagrees with `package.json`:
   ```txt
   version:
     package-lock.json is 0.6.26 but package.json is 0.7.0
   ```

   Editing the three fields directly is enough; there is no need to run `npm install`, which would also re-resolve dependencies.

2. **Add the entry to `CHANGELOG.md`.** The lint check compares its newest
   heading against `package.json`, so the two have to agree.

3. **Open a pull request and let CI pass.** The release workflow repeats these
   checks, but failing here is cheaper than failing mid-publish.

4. **Publish a GitHub release** with the tag `v<version>` - `v0.7.0` for
   version `0.7.0`. The workflow refuses to publish when the tag and `package.json` 
   disagree, so a mistyped tag stops before anything reaches a marketplace.

## What the workflow does

| Step | Notes |
| --- | --- |
| `npm ci` | from the lock file, so the build matches CI |
| format, lint, test | the same three commands CI runs |
| `vsce package` | once, into `ibmi-languages-<version>.vsix` |
| tag check | release tag must equal `v<package.json version>` |
| upload | attaches the `.vsix` to the GitHub release |
| publish | VS Code Marketplace, then Open VSX, from that same file |

If the VS Code Marketplace publish fails, the Open VSX step never runs, and the release
has gone to neither: fix the cause and run the workflow again.

### When only one marketplace has the version

Stopping on the first failure keeps most runs all-or-nothing, but it cannot
cover every case: if the Marketplace publish **succeeds** and Open VSX then
fails, the version is already out on one of them and a publish cannot be rolled
back. Re-running everything would fail on the marketplace that already has it.

Run the workflow by hand and set **targets** to the one still missing:

| targets | Publishes to |
| --- | --- |
| `both` | both marketplaces - the default, and what a release does |
| `vsce` | VS Code Marketplace only |
| `ovsx` | Open VSX only |

## Secrets

| Secret | Used for |
| --- | --- |
| `VSCE_TOKEN` | VS Code Marketplace, an Azure DevOps personal access token |
| `OPEN_VSX` | [Open VSX](https://open-vsx.org/extension/barrettotte/ibmi-languages) access token |

## Running it by hand

`workflow_dispatch` runs the same job without a release: it packages and publishes, but skips the tag check and the upload, 
since there is no release to attach to. It takes the **targets** input described above, so it is also how you
finish a release that only reached one marketplace.

It always packages from the default branch at the version currently in `package.json`, so check that is the version you mean before running it.

To package locally without publishing:

```bash
npm run package
```

`.vscodeignore` is an allowlist - everything is excluded, then the grammars, language configurations, icon and the three top-level documents are added back.
Check the file list `vsce` prints if you add something the extension needs at runtime.
