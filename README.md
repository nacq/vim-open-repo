# vim-open-repo

Another vim plugin to open your current line in the repository website (Github, Gitlab or Bitbucket).

## Installation

As any other plugin.
Example using vim-plug:

```vim
call plug#begin('~/.vim/plugged')

Plug 'nacq/vim-open-repo'

call plug#end()
```

## Usage

Call `:OpenRepo` in any line or visual selection of lines to open the repository url.

## Configuration

Set the browser application to use when opening the repository url.

```vim
let g:vim_open_repo_browser = 'Google Chrome'
```

## Optional configuration

Define a default branch, if this variable is not defined, it will open the current branch.

```vim
let g:vim_open_repo_default_branch = 'develop'
```
