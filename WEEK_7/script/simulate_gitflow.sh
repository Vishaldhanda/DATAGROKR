#!/usr/bin/env bash
# Simulates the full Gitflow lifecycle locally, using --no-ff merges.
# Real PRs happen on GitHub (see README); this shows the branch/merge/tag history.
set -e
export GITFLOW_ALLOW_PROTECTED=1   # allow merge commits on main/develop in the simulation

git checkout main
if git show-ref --verify --quiet refs/heads/develop; then
  git checkout develop
else
  git checkout -b develop main
fi
if git rev-parse -q --verify refs/tags/v1.0.0 >/dev/null; then
  echo "Tag v1.0.0 already exists - simulation already ran in this repo."; exit 1
fi

echo "== 1. Feature branch =="
git checkout -b feature/add-multiply develop
cat >> src/calculator.py <<'PY'


def multiply(a, b):
    return a * b
PY
cat >> tests/test_calculator.py <<'PY'


def test_multiply():
    from src.calculator import multiply
    assert multiply(3, 4) == 12
PY
git add -A && git commit -m "feat: add multiply function"
git checkout develop
git merge --no-ff feature/add-multiply -m "Merge feature/add-multiply into develop"
git branch -d feature/add-multiply

echo "== 2. Release branch =="
git checkout -b release/1.0.0 develop
echo "1.0.0" > VERSION
printf '# Changelog\n\n## 1.0.0\n- Release via Gitflow simulation (includes multiply)\n' > CHANGELOG.md
git add VERSION CHANGELOG.md && git commit -m "chore: bump version to 1.0.0"
git checkout main
git merge --no-ff release/1.0.0 -m "Release 1.0.0"
git tag -a v1.0.0 -m "Release 1.0.0"
git checkout develop
git merge --no-ff release/1.0.0 -m "Merge release/1.0.0 back into develop"
git branch -d release/1.0.0

echo "== 3. Hotfix branch =="
git checkout -b hotfix/1.0.1 main
python3 - <<'PY'
import re, pathlib
p = pathlib.Path("src/calculator.py")
p.write_text(p.read_text().replace("def subtract(a, b):\n    return a - b",
  "def subtract(a, b):\n    # hotfix: explicit numeric handling\n    return a - b"))
PY
echo "1.0.1" > VERSION
printf '\n## 1.0.1\n- Hotfix: harden subtract\n' >> CHANGELOG.md
git add -A && git commit -m "fix: harden subtract (hotfix 1.0.1)"
git checkout main
git merge --no-ff hotfix/1.0.1 -m "Hotfix 1.0.1"
git tag -a v1.0.1 -m "Hotfix 1.0.1"
git checkout develop
git merge --no-ff hotfix/1.0.1 -m "Merge hotfix/1.0.1 back into develop"
git branch -d hotfix/1.0.1

echo "== Done. History: =="
git log --graph --oneline --decorate --all
