# vim-open-repo

Another vim plugin to open your current line in the repository site.

## Usage

Call `:OpenRepo` in any line or visual selection of lines to open the repository url.

## Optional configuration

Define a default branch, if this variable is not defined, it will open the current branch.

```vim
let g:vim_open_repo_default_branch = 'develop'
```
