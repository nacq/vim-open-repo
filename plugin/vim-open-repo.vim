"===========================================================
"" vim-open-repo.vim
" Author: Nicolas Acquaviva <nicolaseacquaviva@gmail.com>
"===========================================================

let s:plugin_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! GetCursorPos()
  let cursor_pos = getpos(".")
  return cursor_pos[1]
endfunction

function! GetVisualSelection()
  let line_start = getpos("'<")[1]
  let line_end = getpos("'>")[1]

  "" TODO handle multiples lines
  "" return the cursor position if the visual selection is just one line
  " if line_start && line_end && line_start != line_end
    " return ["L" . line_start, "L" . line_end]
  " endif

  return getpos(".")[1]
endfunction

function! OpenRepo() range
  let cursor_pos = GetCursorPos()
  let selection = GetVisualSelection()
  let line_param = cursor_pos

  if type(selection) == v:t_list
    line_param = join(selection, ":")
  endif

  execute "!" s:plugin_path . "/open_in_repo.sh" bufname("%") line_param
endfunction

if !exists('g:vim_open_repo_loaded')
  let g:vim_open_repo_loaded = 1
endif
