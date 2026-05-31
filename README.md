# blog

Source for [blog.evanjbowling.com](https://blog.evanjbowling.com/).

## How it works

- Articles live in `articles/<date>-<slug>/`
- GitHub Pages serves the repo directly; `index.md` is the generated home page
- On each PR, the `build` workflow regenerates `index.md` from the current article list and commits it back to the branch

## Creating a new post

```bash
bash scripts/new-post.sh <slug>
```

