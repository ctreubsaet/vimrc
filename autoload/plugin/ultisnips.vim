
" UltiSnips is a framework for code snippets.
" vim-snippets is a community-maintained repository of common code snippets.
"
" Note: The UltiSnips plugin requires the absolute path to the
"       personal snippet directory
" Note: The UltiSnips plugin has reserved the directory name 'snippets'
"       for its own usage so I named the personal snippet directory to 'snippers'.
function plugin#ultisnips#load()
    if !(has('python3'))
      call g:logging#error('The UltiSnips plugin requires python 3.x.')
      return 0
    endif

    Plug g:REPOSITORIES[g:PLUGIN_ULTISNIPS]
    Plug g:REPOSITORIES[g:PLUGIN_SNIPPETS]

  " Configuration {
    " Add the personal snippet directory.
    let g:UltiSnipsSnippetDir = g:DIRECTORY_SNIPPETS

    " Put priority of the personal snippets before those in PLUGIN_SNIPPETS.
    let g:UltiSnipsSnippetDirectories = [g:DIRECTORY_SNIPPETS, "UltiSnips"]

    " Open the UltiSnipsEdit in a vertical buffer.
    let g:UltiSnipsEditSplit = "vertical"
  " }

  " Key bindings {
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
  " }

  return 1
endfunction
