#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
TEMP_ROOT="$(mktemp -d)"
trap 'rm -rf -- "$TEMP_ROOT"' EXIT

HOME="$TEMP_ROOT/home"
export HOME
mkdir -p "$HOME"

cp -R "$PROJECT_ROOT/exercises" "$TEMP_ROOT/exercises"
cd "$TEMP_ROOT/exercises"

bash ./setup_repo.sh
LAB="$TEMP_ROOT/exercises/lab-repo"

[[ -d "$LAB/.git" ]]
[[ "$(git -C "$LAB" branch --show-current)" == "main" ]]
git -C "$LAB" show-ref --verify --quiet refs/heads/feature/observability
git -C "$LAB" show-ref --verify --quiet refs/heads/feature/conflict
[[ "$(git -C "$LAB" rev-list --count --all)" -ge 3 ]]

printf 'demo\n' > "$LAB/logs/demo.log"
status="$(git -C "$LAB" status --short --ignored)"
grep -Fq '!! logs/' <<< "$status"

git -C "$LAB" switch -q main
git -C "$LAB" merge --no-ff -q feature/observability -m "merge feature: observability"

set +e
git -C "$LAB" merge --no-ff feature/conflict >/dev/null 2>&1
merge_status=$?
set -e
[[ $merge_status -ne 0 ]]
[[ -f "$LAB/app/config.txt" ]]
git -C "$LAB" merge --abort

[[ -z "$(git -C "$LAB" status --porcelain)" ]] || { echo 'merge abort left the repository dirty' >&2; exit 1; }

echo "All Git lab tests passed."
