
" ALE provides linting and code formatting while you edit your text files.
"
" Note: The used linters and fixers for each filetype are defined separately
"       in a ftplugin file.
function plugin#ale#load()
  if version < 800
    call g:logging#error('The ALE plugin requires VIM 8.0 (800) or higher.')
    return 0
  endif

  Plug g:REPOSITORIES[g:PLUGIN_ALE]

  " Configuration {
    " Only run the linters when you save a file.
    let g:ale_lint_on_text_changed = 'never'
    let g:ale_lint_on_enter = 0
    let g:ale_lint_on_insert_leave = 0
  " }

  " Key bindings {
    " Apply the code formatter(s) on the buffer.
    nnoremap <space>a :ALEFix<CR>

    nmap <silent> [a <Plug>(ale_previous_wrap)zz
    nmap <silent> ]a <Plug>(ale_next_wrap)zz
  " }

  return 1
endfunction
