# Git Log Graph

Review log graph feature and config.

### Overview

Use a customized `git log --graph` command configured as an
alias for easy exploration of recent git history and related
branches. Leverage simpler `git log` and `git show` commands
to dig into specific commits.

## Getting Started

The basic command `git log --graph` is verbose:

```shell
* commit 24308a5078194424b49b9e24750b7e421adb8ac2 (HEAD -> b)
| Author: Hiro Protagonist <user@domain.co.uk>
| Date:   Fri Nov 7 19:53:02 2025 -0000
| 
|     Update b.txt
| 
* commit 379e29ca63ac66e9e7a2bf916ea06460e0a31ac1
| Author: Hiro Protagonist <user@domain.co.uk>
| Date:   Fri Nov 7 19:53:01 2025 -0000
| 
|     Update b.txt
| 
```

It's very similar to the regular `git log` output. By adding a format
we can condense every commit to a single line. Try:

`git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s'`

```shell
* 24308a5 - (HEAD -> b) Update b.txt
* 379e29c - Update b.txt
* a7d4883 - Update b.txt
* e30d045 - Update b.txt
* ec7c2b5 - Add b.txt
* 0222637 - Update main.txt
* 63c8139 - Update main.txt
* 23900e2 - Update main.txt
* 642228a - Update main.txt
* ea4f22b - Add main.txt
* 86dbcee - Initial commit
```

<pre style="background-color: #1e1e1e; color: #d4d4d4; padding: 15px; border-radius: 5px; overflow-x: auto; font-family: 'Consolas', 'Monaco', 'Courier New', monospace; line-height: 1.4;">* <span style="color: #cd3131">24308a5</span> -<span style="color: #e5e510"> (HEAD -&gt; b)</span> Update b.txt
* <span style="color: #cd3131">379e29c</span> -<span style="color: #e5e510"> Update b.txt</span>
* <span style="color: #cd3131">a7d4883</span> -<span style="color: #e5e510"> Update b.txt</span>
* <span style="color: #cd3131">e30d045</span> -<span style="color: #e5e510"> Update b.txt</span>
* <span style="color: #cd3131">ec7c2b5</span> -<span style="color: #e5e510"> Add b.txt</span>
* <span style="color: #cd3131">0222637</span> -<span style="color: #e5e510"> Update main.txt</span>
* <span style="color: #cd3131">63c8139</span> -<span style="color: #e5e510"> Update main.txt</span>
* <span style="color: #cd3131">23900e2</span> -<span style="color: #e5e510"> Update main.txt</span>
* <span style="color: #cd3131">642228a</span> -<span style="color: #e5e510"> Update main.txt</span>
* <span style="color: #cd3131">ea4f22b</span> -<span style="color: #e5e510"> Add main.txt</span>
* <span style="color: #cd3131">86dbcee</span> -<span style="color: #e5e510"> Initial commit</span></pre>

Try the following:

```bash
git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
```

## Example Repo

Let's make a smallish repo with enough complexity to be interesting:

```bash
mkdir test
cd test
git init
echo test > test.txt
echo "# test" > README.md
git add .
git commit -m 'Initial commit'
git checkout -b a
echo test > a.txt
git add a.txt
git commit -m 'Add a.txt'
echo 1 >> a.txt
git add a.txt
git commit -m 'Update a.txt'
echo 2 >> a.txt
git add a.txt
git commit -m 'Update a.txt'
git checkout main
echo 1 >> main.txt
git add main.txt
git commit -m 'Add main.txt'
echo 2 >> main.txt
git add main.txt
git commit -m 'Update main.txt'
echo 3 >> main.txt
git add main.txt
git commit -m 'Update main.txt'
echo 4 >> main.txt
git add main.txt
git commit -m 'Update main.txt'
echo 5 >> main.txt
git add main.txt
git commit -m 'Update main.txt'
git checkout -b b
echo b1 > b.txt
git add b.txt
git commit -m 'Add b.txt'
echo b2 >> b.txt
git add b.txt
git commit -m 'Update b.txt'
git checkout main
echo 6 >> main.txt
git add main.txt
git commit -m 'Update main.txt'
echo 7 >> main.txt
git add main.txt
git commit -m 'Update main.txt'
git merge a -m 'Merge branch a'
git checkout b
echo b3 >> b.txt
git add b.txt
git commit -m 'Update b.txt'
echo b4 >> b.txt
git add b.txt
git commit -m 'Update b.txt'
git checkout -b c
echo c1 > c.txt
git add c.txt
git commit -m 'Add c.txt'
echo c2 >> c.txt
git add c.txt
git commit -m 'Update c.txt'
git checkout b
echo b5 >> b.txt
git add b.txt
git commit -m 'Update b.txt'
```

## Additional Features

Only display merge commits with: `git lgt --min-parents=2`:

```shell
```

Omit commits from the main branch when looking at a feature branch:

```shell
```

Only display root commits: `git lgt --max-parents=0`:

```shell
```

Normally this shows only a single commit, but it's possible to have
more. A common reason for having these is using a tool
like [git-filter-repo](https://github.com/newren/git-filter-repo) to
merge two separate git histories. Here's a manufactured example:

```shell
mkdir test
cd test
git init
echo 1 > main.txt
git add main.txt
git commit -m 'Add main.txt'
git checkout --orphan a
echo 2 > a.txt
git add a.txt
git commit -m 'Add a.txt'
git checkout --orphan b
echo 3 > b.txt
git add b.txt
git commit -m 'Add b.txt'
git merge --allow-unrelated-histories a -m 'Merge branch a'
git merge --allow-unrelated-histories b -m 'Merge branch b'
```


