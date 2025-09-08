# GitHub Merge

Examination of git merge approaches within GitHub and impacts.

## Getting Started

Let's make a repo:

```bash
mkdir test
cd test
git init
echo "test" > test.txt
echo "# test" > README.md
git add .
git commit -m 'Initial commit'
```

We now have a single commit. Grand.

```bash
git lg
#* 8c51ebb - (HEAD -> main) Initial commit
```

## GitHub PR Merge Options

GitHub gives us three options to merge. Let's do one of each:

1. Create a merge commit
2. Squash and merge
3. Rebase and merge

Let's make some PRs and test out our options. We'll create 3
branches: `a`, `b` and `c`.

```bash
# a
git checkout -b a
echo "oh" > a.txt
git add a.txt 
git commit -m 'Add a.txt'
git push -u origin HEAD
git lg
#* e0978ae - (HEAD -> a, origin/a) Add a.txt
#* 8c51ebb - (origin/main, main) Initial commit

# b
git checkout main
git checkout -b b
echo "hey" > b.txt
git add b.txt 
git commit -m 'Add b.txt'
git push -u origin HEAD
git lg
#* 40bd825 - (HEAD -> b, origin/b) Add b.txt
#* 8c51ebb - (origin/main, main) Initial commit

# c
git checkout main
git checkout -b c
echo "hello there" > c.txt
git add c.txt 
git commit -m 'Add c.txt'
git push -u origin HEAD
echo ", George." >> c.txt
git add c.txt
git commit -m 'Edit c.txt'
git push
#* bda1792 - (HEAD -> c, origin/c) Edit c.txt
#* 4fa0525 - Add c.txt
#* 8c51ebb - Initial commit
```

Option 1 creates a new "merge commit" with two parents: one pointing to the tip of our "a"
branch and one pointing to the tip of "main":

```bash
#*   f2eb63c - (HEAD -> main, origin/main) Merge pull request #1 from evanjbowling/a
#|\  
#| * e0978ae - (origin/a, a) Add a.txt
#|/  
#* 8c51ebb - Initial commit
```

We can also see the multiple parents using `git show --format=raw`:

```bash
commit f2eb63c8411491f6ca4379b38ebe7f0473b6f0ff
tree 4f22d7e0d8d7c9789ba608720ce0c58536e84b08
parent 8c51ebbd3ea9e3bad56a5dc3ccf02ca8a92eabfb
parent e0978ae8192e40d2d8c16156b6403ac7c89e9a9a
...
```

Option 2 creates a single new commit constructed from squashing all the commits on the
"b" branch and pointing to the tip of "main":

```bash
#* d522e87 - (HEAD -> main, origin/main) Add b.txt (#2)
#*   f2eb63c - Merge pull request #1 from evanjbowling/a
#|\  
#| * e0978ae - (origin/a, a) Add a.txt
#|/  
#* 8c51ebb - Initial commit
```

Option 3 is similar to option 2 except that it won't squash all the commits together.
For every new commit in branch "c" we will see one new commit added to the tip of the
"main" branch.

```bash
#* 8034755 - (HEAD -> main, origin/main) Edit c.txt
#* eebc3c6 - Add c.txt
#* d522e87 - Add b.txt (#2)
#*   f2eb63c - Merge pull request #1 from evanjbowling/a
#|\  
#| * e0978ae - (origin/a, a) Add a.txt
#|/  
#* 8c51ebb - Initial commit
```

## Git CLI

You can accomplish the same actions using git commands. Let's checkout the intial commit
and make a `new-main` branch so that we can redo this from the CLI (and compare the output).

```bash
git checkout 8c51ebb
git checkout -b new-main
git lg
#* 8c51ebb - (HEAD -> new-main) Initial commit (3 days ago)
```

Ok, let's do option 1. By default, a fast-forward merge is attempted but we
want to force a merge commit so we need to use the `--no-ff` option:

```bash
git merge --no-ff -m "Merge branch 'a' into new-main" a
git lg
#*   0dde62d - (HEAD -> new-main) Merge branch 'a' into new-main
#|\  
#| * e0978ae - (origin/a, a) Add a.txt
#|/  
#* 8c51ebb - Initial commit
```

The squash merge (option 2) needs two commands. The merge stages
the changes, and then a normal commit produces the same effect.

```bash
git merge --squash b && git commit -m "Merge branch 'b' into new-main"
git lg
#* 94d411a - (HEAD -> new-main) Merge branch 'b' into new-main
#*   0dde62d - Merge branch 'a' into new-main
#|\  
#| * e0978ae - (origin/a, a) Add a.txt
#|/  
#* 8c51ebb - Initial commit
```

For the rebase merge (option 3) we need to do a few steps: checkout
the feature branch `c`, rebase it for the target branch `new-main`,
then checkout `new-main` and merge it in.

```bash
git checkout c
git lg
#* bda1792 - (HEAD, origin/c) Edit c.txt
#* 4fa0525 - Add c.txt
#* 8c51ebb - Initial commit
git rebase new-main
Successfully rebased and updated detached HEAD.
git lg
#* d36543b - (HEAD -> c) Edit c.txt
#* 5467d43 - Add c.txt
#* 94d411a - (new-main) Merge branch 'b' into new-main
#*   0dde62d - Merge branch 'a' into new-main
#|\  
#| * e0978ae - (origin/a, a) Add a.txt
#|/  
#* 8c51ebb - Initial commit
git checkout new-main
git merge --ff-only c
git lg
#* d36543b - (HEAD -> new-main, c) Edit c.txt
#* 5467d43 - Add c.txt
#* 94d411a - Merge branch 'b' into new-main
#*   0dde62d - Merge branch 'a' into new-main
#|\  
#| * e0978ae - (origin/a, a) Add a.txt
#|/  
#* 8c51ebb - Initial commit
```

We can show we end up with the exact same contents as the GitHub approach:

```bash
git diff new-main..main # no output
```

## Octopus Merge

There's another option available within the CLI where we merge multiple branches
at once. With these simple branches (no conflicting file edits) this is an easy
case to demonstrate this.

Let's create `one-more-main` branch from the initial commit.

```bash
git checkout 8c51ebb
git checkout -b one-more-main
git lg
* 8c51ebb - (HEAD -> one-more-main) Initial commit
```

We need to reset `c` to it's original state (i.e. not being rebased onto `new-main`):

```bash
git branch -D c
git checkout bda1792
git checkout -b c
```

Let's try the merge:

```bash
git merge a b c
Fast-forwarding to: a
Trying simple merge with b
Trying simple merge with c
Merge made by the 'octopus' strategy.
 a.txt | 1 +
 b.txt | 1 +
 c.txt | 2 ++
 3 files changed, 4 insertions(+)
 create mode 100644 a.txt
 create mode 100644 b.txt
 create mode 100644 c.txt
git lg
#*-.   dabeb92 - (HEAD -> one-more-main) Merge branches 'a', 'b' and 'c' into one-more-main
#|\ \  
#| | * bda1792 - (origin/c, c) Edit c.txt
#| | * 4fa0525 - Add c.txt
#| * | 40bd825 - (origin/b, b) Add b.txt
#| |/  
#* / e0978ae - (origin/a, a) Add a.txt
#|/  
#* 8c51ebb - Initial commit
```

It still attempted to fast-forward by default. Let's do that one more time
without fast-forward.

```bash
git reset --hard 8c51ebb
git lg
#* 8c51ebb - (HEAD -> one-more-main) Initial commit
```

Now, let's use the `--no-ff` option:

```bash
git merge --no-ff a b c
Fast-forwarding to: a
Trying simple merge with b
Trying simple merge with c
Merge made by the 'octopus' strategy.
 a.txt | 1 +
 b.txt | 1 +
 c.txt | 2 ++
 3 files changed, 4 insertions(+)
 create mode 100644 a.txt
 create mode 100644 b.txt
 create mode 100644 c.txt
```

The `git lg` output:

```bash
#*---.   37b9760 - (HEAD -> one-more-main) Merge branches 'a', 'b' and 'c' into one-more-main
#|\ \ \  
#| | | * bda1792 - (origin/c, c) Edit c.txt
#| | | * 4fa0525 - Add c.txt
#| |_|/  
#|/| |   
#| | * 40bd825 - (origin/b, b) Add b.txt
#| |/  
#|/|   
#| * e0978ae - (origin/a, a) Add a.txt
#|/  
#* 8c51ebb - Initial commit
```

Ok, the output looks busy but is conceptually simple: there is an initial commit,
then three branches a, b and c that are finally merged back in a single merge commit `37b9760`.

Let's see the parents of this commit (`git show --format=raw`):

```bash
commit 37b9760695ceff62bb6ceaccb9c4e22c3c5b7842
tree 5c9fb1169deb652926158cc8aa9367e0ed1bca84
parent 8c51ebbd3ea9e3bad56a5dc3ccf02ca8a92eabfb
parent e0978ae8192e40d2d8c16156b6403ac7c89e9a9a
parent 40bd82558b3e14132d6e0a1d1d02c2e759903ac4
parent bda17922e388b1ebff29ab6bc98d26b47f8a13b9
...
```

The above is really the same as option 1 but with multiple branches. Now, attempting
to do option 2 with multiple branchs we find that we can't use `--squash` and `--no-ff`
together. This means the order we list the branches in matters:

```bash
git reset --hard 8c51ebb
git merge --squash a b c
Fast-forwarding to: a                         # fast forwards to a
Trying simple merge with b
Trying simple merge with c
Squash commit -- not updating HEAD
Automatic merge went well; stopped before committing as requested
```

```bash
git reset --hard 8c51ebb
git merge --squash b a c
Fast-forwarding to: b                         # fast forwards to b
Trying simple merge with a
Trying simple merge with c
Squash commit -- not updating HEAD
Automatic merge went well; stopped before committing as requested
```

That's it!
