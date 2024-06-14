"===========================================================
"" vim-open-repo.vim
" Author: Nicolas Acquaviva <nicolaseacquaviva@gmail.com>
"===========================================================

let s:plugin_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! GetVisualSelection()
  let line_start = getpos("'<")[1]
  let line_end = getpos("'>")[1]

  " delete marks used by the latest visual selection to avoid opening the same again
  delmarks < >

  " return the cursor position if the visual selection is just one line
  if line_start != 0 && line_end != 0 && line_start != line_end
    return join([line_start, line_end], " ")
  endif

  return getpos(".")[1]
endfunction

" 'range' will avoid the command to execute multiple times when there is a range selection
function! OpenRepo() range
  if !exists('g:vim_open_repo_browser')
    echo "Error: The variable g:vim_open_repo_browser needs to be set"
    return
  endif

  let default_branch = 0
  let selection = GetVisualSelection()
  " current file path relative to the git project
  let current_file = expand('%:.')

  if exists('g:vim_open_repo_default_branch')
    let default_branch = g:vim_open_repo_default_branch
  endif

  let browser = g:vim_open_repo_browser

  " wrapping the browser variable with quotes to send a string containing spaces as a single argument to the script
  execute "!" s:plugin_path . "/open_in_repo.sh" . " " . current_file . " " .  default_branch . " " .  "\"" . browser . "\"" . " " . selection
endfunction

if !exists('g:vim_open_repo_loaded')
  let g:vim_open_repo_loaded = 1

  execute "command! -range OpenRepo :call OpenRepo()"
endif
