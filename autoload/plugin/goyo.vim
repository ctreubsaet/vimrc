
" Goyo and Limelight create a distraction-free environment for writing text.
function plugin#goyo#load()
  Plug g:REPOSITORIES[g:PLUGIN_GOYO]
  Plug g:REPOSITORIES[g:PLUGIN_LIMELIGHT]

  " Configuration {
    " Toggle PLUGIN_LIMELIGHT together with PLUGIN_GOYO.
    function! s:goyo_enter()
        Limelight
    endfunction

    function! s:goyo_leave()
        Limelight!
    endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
  " }

  " Key bindings {
    nnoremap <space>g :Goyo<CR>
  " }

  return 1
endfunction
