# Git Bare Repo

Basics of how and why I use bare git repos.

## Overview

There are times when I want to version files and use git but I don't
want to push my data to GitHub (or any other cloud VCS). This could 
be for multiple reasons but usually it's because of sensitive data.
Bare repos are useful here because I can set up a local repo on a separate
machine and connect to it the same as GitHub. Bare repos have all the 
version history capabilities of a regular repo - they're just missing the
working directory. This gives me a single backup without worrying about
any additional interface - and a location to script even more backup
infrastructure later.

## The Details

You can create local git repos _anywhere_ - this is part of what
makes git so useful. `git init` and you're off to the races. This
time we create it slightly differently: `git init --bare repo.git`.

Let's make one:

```bash
d=$(mktemp -d)
cd "$d"
mkdir source
mkdir local
cd source
git init --bare --initial-branch=main repo.git
cd ../local
git clone "$d/source/repo.git"
cd repo
```

Checking your git status should show:

```
$ git status
On branch main

No commits yet

nothing to commit (create/copy files and use "git add" to track)
```

Add a commit

```bash
echo "sample project" > README.md
git add README.md
git commit -m 'chore: initial commit'
git push
# list the objects
find .git/objects -type f
#.git/objects/59/c66230d09ae9d7552f94e667f183a3476dbf46
#.git/objects/ff/d351deceabeaa093e2a5a4900894d64eea5b8b
#.git/objects/4f/ed7308f1323e3272bc1bde0e6694d95cf523ce
```

And inspect the bare repo:

```bash
cd ../../source/repo.git
# in a bare repo, the HEAD file represents the default branch
cat HEAD 
#ref: refs/heads/main

# list the objects
find objects -type f
#objects/59/c66230d09ae9d7552f94e667f183a3476dbf46
#objects/ff/d351deceabeaa093e2a5a4900894d64eea5b8b
#objects/4f/ed7308f1323e3272bc1bde0e6694d95cf523ce

# print each object type, id and contents
for o in $(find objects -type f | sed 's|objects/||' | sed 's|/||'); do
  echo "$(git cat-file -t $o) - $o"
  git cat-file -p $o
done
#commit - 59c66230d09ae9d7552f94e667f183a3476dbf46
#tree ffd351deceabeaa093e2a5a4900894d64eea5b8b
#author Yooser Nahm <ynahm@domain.co.uk> 1774705030 -0500
#committer Yooser Nahm <ynahm@domain.co.uk> 1774705030 -0500
#
#chore: initial commit
#tree - ffd351deceabeaa093e2a5a4900894d64eea5b8b
#100644 blob 4fed7308f1323e3272bc1bde0e6694d95cf523ce	README.md
#blob - 4fed7308f1323e3272bc1bde0e6694d95cf523ce
#sample project
```

You can change the default branch in the bare repo with:

```bash
# read the value
git symbolic-ref HEAD
#refs/heads/main
# set it
git symbolic-ref HEAD refs/heads/master
git symbolic-ref HEAD
#refs/heads/master
# and back again
git symbolic-ref HEAD refs/heads/main
```

## SSH

You can clone a repo directly from another machine over SSH like:

```
git clone ssh://user@host:/path/to/repo.git
```

and then interact with it as usual. This will show up in your remote
configuration:

```
git remote -v
origin  ssh://user@host:/path/to/repo.git (fetch)
origin  ssh://user@host:/path/to/repo.git (push)
```

Fin.

