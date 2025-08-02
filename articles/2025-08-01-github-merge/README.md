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
* 8c51ebb - (HEAD -> main) Initial commit (36 seconds ago) <Evan Bowling>
```

Let's make some PRs and test out our options:

```bash
# a
git checkout -b a
echo "oh" > a.txt
git add a.txt 
git commit -m 'Add a.txt'
git push -u origin HEAD
git lg
#* e0978ae - (HEAD -> a, origin/a) Add a.txt (8 minutes ago) <Evan Bowling>
#* 8c51ebb - (origin/main, main) Initial commit (18 minutes ago) <Evan Bowling>
# b
git checkout main
git checkout -b b
echo "hey" > b.txt
git add b.txt 
git commit -m 'Add b.txt'
git push -u origin HEAD
git lg
#* 40bd825 - (HEAD -> b, origin/b) Add b.txt (7 minutes ago) <Evan Bowling>
#* 8c51ebb - (origin/main, main) Initial commit (17 minutes ago) <Evan Bowling>
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
#* bda1792 - (HEAD -> c, origin/c) Edit c.txt (6 seconds ago) <Evan Bowling>
#* 4fa0525 - Add c.txt (18 minutes ago) <Evan Bowling>
#* 8c51ebb - Initial commit (29 minutes ago) <Evan Bowling>
```

Github gives us three options to merge. Let's do one of each:

1. Create a merge commit
2. Squash and merge
3. Rebase and merge

Option 1 creates a new "merge commit" with two parents: one pointing to the tip of our "a"
branch and one pointing to the tip of "main":

```
*   f2eb63c - (HEAD -> main, origin/main) Merge pull request #1 from evanjbowling/a (51 seconds ago) <Evan Bowling>
|\  
| * e0978ae - (origin/a, a) Add a.txt (10 minutes ago) <Evan Bowling>
|/  
* 8c51ebb - Initial commit (19 minutes ago) <Evan Bowling>
```

Option 2 creates a single new commit constructed from squashing all the commits on the
"b" branch and pointing to the tip of "main":

```
* d522e87 - (HEAD -> main, origin/main) Add b.txt (#2) (16 seconds ago) <Evan Bowling>
*   f2eb63c - Merge pull request #1 from evanjbowling/a (3 minutes ago) <Evan Bowling>
|\  
| * e0978ae - (origin/a, a) Add a.txt (12 minutes ago) <Evan Bowling>
|/  
* 8c51ebb - Initial commit (22 minutes ago) <Evan Bowling>
```

Option 3 is similar to option 2 except that it won't squash all the commits together.
For every new commit in branch "c" we will see one new commit added to the tip of the
"main" branch.

```
* 8034755 - (HEAD -> main, origin/main) Edit c.txt (4 minutes ago) <Evan Bowling>
* eebc3c6 - Add c.txt (4 minutes ago) <Evan Bowling>
* d522e87 - Add b.txt (#2) (12 minutes ago) <Evan Bowling>
*   f2eb63c - Merge pull request #1 from evanjbowling/a (15 minutes ago) <Evan Bowling>
|\  
| * e0978ae - (origin/a, a) Add a.txt (24 minutes ago) <Evan Bowling>
|/  
* 8c51ebb - Initial commit (34 minutes ago) <Evan Bowling>
```



