---
name: update-brewfile
description: Reconcile ~/.Brewfile (the repo's .Brewfile) with what's actually installed via Homebrew, keeping it grouped into categories with a one-line description per entry. Use when the user asks to update/regenerate/refresh the Brewfile, capture manually-installed brew tools, or re-organize it.
---

# Update the Brewfile

Goal: make `.Brewfile` (symlinked to `~/.Brewfile`) reflect what is actually
installed, organized into commented categories with a short description on every
line. This is a hand-curated file — do NOT replace it with raw `brew bundle dump`
output, which loses the categories and comments.

## 1. Gather the real installed state

Run these and read the output:

```sh
brew leaves                          # manually-installed formulae (NOT deps)
brew list --cask                     # casks
mas list                             # Mac App Store apps
brew tap                             # active taps
brew desc --eval-all $(brew leaves)  # one-line descriptions for formulae
for c in $(brew list --cask); do d=$(brew desc --cask "$c" 2>/dev/null); echo "${d:-$c: }"; done
```

Use `brew leaves` (not `brew list`) as the source of truth for formulae — it
excludes packages that are only present as dependencies of something else.

## 2. Reconcile against the current .Brewfile

- **Add** anything in `brew leaves` / casks / `mas list` that's missing.
- **Drop pure dependencies** that Homebrew pulls in automatically (e.g. `boost`,
  `glib`, `poppler`, `harfbuzz`, `pango`, `librsvg`, `oniguruma`). If it's not in
  `brew leaves`, it does not belong as its own line.
- **Remove stale entries** that are no longer installed.
- **Preserve intentional flags** like `link: false` (e.g. doppler).
- **Preserve hand-written migration/context notes.** Some comments record
  history that is NOT reproducible from `brew desc` — keep them verbatim. Known
  notes to never drop:
  - `rectangle` — "successor to the discontinued Spectacle"
  Before rewriting, diff your new content against the existing `.Brewfile` and
  carry over any comment that explains *why* an entry exists or what it replaced.

## 3. Write it back, grouped + described

- Keep the existing category structure (Shell & terminal, Core CLI utilities,
  Search, Version control, Build tools, Languages & runtime managers,
  Cloud/infra/Kubernetes, Databases, Networking & HTTP, Media, Documents &
  publishing, Security, Misc, Editors, FUSE; then Casks by group; then mas apps).
  Add categories as needed; place new tools in the best-fitting one.
- One trailing `# comment` per line, taken from `brew desc`. For formulae with an
  empty description (e.g. `mgccli`, `flyctl`), write a short accurate one.
- For tap-provided formulae, use the fully-qualified name
  (e.g. `brew "superfly/tap/flyctl"`) and declare the tap at the top. Verify the
  tap name with `brew tap` — names can differ from the formula path
  (e.g. doppler lives in `dopplerhq/doppler`, not `dopplerhq/cli`).

## 4. Validate

```sh
HOMEBREW_NO_AUTO_UPDATE=1 brew bundle check --global --verbose
```

Lines saying a package "needs to be installed or updated" are usually just
**outdated** packages — that's expected and fine. The errors that matter are
"needs to be tapped" (wrong/missing tap) or a package that genuinely isn't
installed (a typo). Fix those, then stop.

Do not run `brew bundle install`, `brew upgrade`, or commit unless asked.
