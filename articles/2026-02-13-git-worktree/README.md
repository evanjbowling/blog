# Git Worktree

Explore git worktree and work on multiple branches simultaneously.

## Overview

Let's say you're working on a feature branch and need to check something on `main`.
One approach is to `git stash` your work and switch branches. This works but is
disruptive. `git worktree` gives us another option: check out multiple branches at
the same time in separate directories. This is different from cloning the repo again
because the git worktree reuses the same object file history.

### Summary

| Action | Command |
|---|---|
| List worktrees | `git worktree list` |
| Add worktree for existing branch | `git worktree add <path> <branch>` |
| Add worktree with new branch | `git worktree add -b <branch> <path> <commit-ish>` |
| Add detached worktree | `git worktree add --detach <path> <commit-ish>` |
| Remove a worktree | `git worktree remove <path>` |
| Prune stale metadata | `git worktree prune` |

## Getting Started

Let's make a repo:

```bash
# make the repo
mkdir myproject
cd myproject
git init
echo "# myproject" > README.md
echo "v1" > app.txt
git add .
git commit -m 'Initial commit'
```

## Add a Worktree

Let's create a branch and worktree in two steps:

```bash
git branch feature-x
git worktree add ../myproject-feature-x feature-x
```

That created a new directory `../myproject-feature-x` with the `feature-x` branch
checked out. Our original directory stays on `main`. Two directories, two branches,
one repo.

Let's verify:

```bash
# Navigate to the worktree directory
cd ../myproject-feature-x
git branch --show-current
#feature-x

# Navigate back to the original directory
cd ../myproject
git branch --show-current
#main
```

## Work in Parallel

Now let's do some work in both places.

**Terminal 1** (main):

```bash
# Still in original directory
echo "v2" > app.txt
git add app.txt
git commit -m 'Update app to v2'
git lg
#* c982b34 - (HEAD -> main) Update app to v2
#* 0392805 - (feature-x) Initial commit
```

**Terminal 2** (feature-x):

```bash
# Navigate to the worktree directory
cd ../myproject-feature-x
cat app.txt
#v1
echo "new feature" > feature.txt
git add feature.txt
git commit -m 'Add feature'
git lg
#* 4d832e8 - (HEAD -> feature-x) Add feature
#* 0392805 - Initial commit
```

Notice that `app.txt` in the worktree still shows `v1`. The worktree has its own
working directory, its own index, and its own HEAD. The two directories don't
interfere with each other at all. You can still see the commits of the feature-x
branch in the main directory because they really do share the same repo and object
history:

```bash
# Navigate to the original directory
cd ../myproject
git lg --all
#* 4d832e8 - (feature-x) Add feature
#| * c982b34 - (HEAD -> main) Update app to v2
#|/  
#* 0392805 - (feature-y) Initial commit
```

## Inspect the `.git` files

There's one `.git` directory in the original repo. The worktree has a `.git` file
that points back to the original repo.

Let's verify:

```bash
cat myproject-feature-x/.git
#gitdir: <absolute-path>/myproject/.git/worktrees/myproject-feature-x
```

It's a file, not a directory. The contents refer to the path in the main
repo where the worktree objects are managed.

```bash
cd myproject # the main repo where the objects are stored
cat .git/worktrees/myproject-test/gitdir 
#<absolute-path>/myproject-test/.git

ls .git/worktrees/myproject-test
#commondir	HEAD		logs		refs
#gitdir		index		ORIG_HEAD
```

## List and Remove Worktrees

To see what worktrees exist:

```bash
git worktree list
#<absolute-path>/myproject              c982b34 [main]
#<absolute-path>/myproject-feature-x    4d832e8 [feature-x]
```

When you're done with a worktree, remove it:

```bash
git worktree remove ../myproject-feature-x
git worktree list
#<asbolute-path>/myproject    c982b34 [main]
```

The branch still exists but the `myproject-feature-x` working directory is gone:

```bash
git branch
#  feature-x
#* main
```

## Create a New Branch Directly

You don't need to create the branch first. The `-b` flag does both at once:

```bash
git worktree add -b hotfix ../myproject-hotfix main
#Preparing worktree (new branch 'hotfix')
#HEAD is now at c982b34 Update app to v2
```

This created a new `hotfix` branch starting from `main` and checked it out
in `../myproject-hotfix`. One command.

```bash
git worktree list
#<absolute-path>/myproject            c982b34 [main]
#<absolute-path>/myproject-hotfix     c982b34 [hotfix]
```

## A Rule: One Branch Per Worktree

Git enforces that a branch can only be checked out in one worktree at a time.
If you try to check out `main` in a second worktree you'll get an error:

```bash
git worktree add ../another main
#fatal: 'main' is already checked out at '<absolute-path>/myproject'
```

## Temporary Worktrees

Create a detached worktree from any commit or tag for quick one-off tasks:

```bash
git worktree add --detach ../myproject-check a1b2c3d
#Preparing worktree (detached HEAD a1b2c3d)
#HEAD is now at a1b2c3d Initial commit

cd ../myproject-check
git lg
#* 0392805 - (HEAD) Initial commit
```

Useful for inspecting an old release or commit.

## Cleanup

If a worktree directory gets deleted manually (e.g. `rm -rf`) instead of using
`git worktree remove`, the metadata can linger. Clean it up with:

```bash
git worktree prune
```

