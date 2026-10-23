# Full Gitflow Simulation

A mini project that demonstrates the complete **Gitflow** lifecycle:
feature branch → PR → merge → release → hotfix, plus a **pre-commit hook** and **GitHub Actions CI**.

## Branch model
| Branch | Purpose |
|---|---|
| `main` | Production-ready code, tagged releases (`v1.0.0`, `v1.0.1`) |
| `develop` | Integration branch for finished features |
| `feature/*` | New work, branched from `develop`, merged back via PR |
| `release/*` | Release prep, branched from `develop`, merged into `main` + `develop` |
| `hotfix/*` | Urgent fixes, branched from `main`, merged into `main` + `develop` |

## Setup
```bash
pip install -r requirements.txt
./scripts/setup-hooks.sh      # enables the pre-commit hook
pytest
```

## Pre-commit hook (`.githooks/pre-commit`)
- Blocks direct commits to `main` / `develop`
- Runs `flake8` and `pytest` before every commit
- `commit-msg` hook enforces conventional commits (`feat: ...`, `fix: ...`)
- Hooks can be bypassed with `--no-verify`, so CI is the real safety net

## CI (`.github/workflows/ci.yml`)
Runs lint + tests on pushes to `main`, `develop`, `feature/**`, `release/**`, `hotfix/**` and on PRs to `main` / `develop`.

Pushing a `v*` tag triggers `.github/workflows/release.yml`, which creates a GitHub Release.

## Run the local simulation
```bash
./scripts/simulate_gitflow.sh
```
Prints the final `git log --graph` showing the whole lifecycle.

## Real PR workflow on GitHub
```bash
git checkout -b feature/my-change develop
# ...edit, commit...
git push -u origin feature/my-change
gh pr create --base develop --title "feat: my change" --body "Description"
gh pr merge --no-ff --delete-branch      # or merge in the UI
```
