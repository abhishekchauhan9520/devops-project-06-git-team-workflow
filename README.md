# Project 06 — Version Control with Git: Exercises + Team Workflow

A reproducible Git laboratory for learning the everyday workflow used by development teams.

## What you will practice

- Initialize and inspect repositories
- Create focused commits
- Work with feature branches
- Merge branches safely
- Reproduce and resolve a merge conflict
- Tag a release
- Inspect history and recover a deleted file with `git restore`
- Use `.gitignore`
- Push a local repository to a remote

## Requirements

- Git 2.x
- Bash

## Quick start

```bash
./exercises/setup_repo.sh
cd exercises/lab-repo
```

The setup script creates an isolated lab repository with a `main` branch, a feature branch, sample commits, and a deliberately conflicting branch.

## Suggested exercise order

1. Inspect history with `git log --oneline --graph --decorate --all`.
2. Switch to `feature/observability` and inspect its commit.
3. Merge it into `main` with `git merge --no-ff feature/observability`.
4. Switch to `feature/conflict`, merge it into `main`, and resolve the conflict in `app/config.txt`.
5. Create a release tag: `git tag -a v1.0.0 -m "Release 1.0.0"`.
6. Practice recovery by deleting a tracked file and restoring it with `git restore`.
7. Inspect ignored files by creating `logs/demo.log` and running `git status --ignored`.
8. Simulate remote collaboration using your own GitHub repository with `git remote add origin ...` and `git push -u origin main`.

## Safety

The setup script writes only inside `exercises/lab-repo`. It refuses to overwrite an existing lab directory unless you pass `--force`.

## Validation

Run:

```bash
./tests/test_git_lab.sh
```

The tests create a temporary repository, execute the setup workflow, and verify branches, commits, ignored files, and the conflict scenario.
