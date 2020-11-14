"===========================================================
"" vim-open-repo.vim
" Author: Nicolas Acquaviva <nicolaseacquaviva@gmail.com>
"===========================================================

let s:plugin_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! GetVisualSelection()
  let line_start = getpos("'<")[1]
  let line_end = getpos("'>")[1]

  " return the cursor position if the visual selection is just one line
  if line_start != 0 && line_end != 0 && line_start != line_end
    return join([line_start, line_end], " ")
  endif

  return getpos(".")[1]
endfunction

" 'range' will avoid the command to execute multiple times when there is a range selection
function! OpenRepo() range
  let default_branch = 'master'
  let selection = GetVisualSelection()

  if exists('g:vim_open_repo_default_branch')
    let default_branch = g:vim_open_repo_default_branch
  endif

  execute "!" s:plugin_path . "/open_in_repo.sh" bufname("%") default_branch selection
endfunction

if !exists('g:vim_open_repo_loaded')
  let g:vim_open_repo_loaded = 1

  execute "command! -range OpenRepo :call OpenRepo()"
endif
