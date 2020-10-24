
" fzf is a command-line fuzzy finder with a plugin to integrate with Vim.
" fzf vim is a bundle of fzf-based commands and mappings.
"
" Note: The fzf plugin is already included in the fzf installation and referred
"       from the home directory.
" Note: The fzf vim plugin depends on the fzf plugin.
function plugin#fzf#load()
  if !(executable('fzf'))
    call g:logging#error('The fzf command cannot be found')
    return 0
  endif

  if !(executable('rg'))
    call g:logging#error('The ripgrep command cannot be found.')
    return 0
  endif

  Plug g:REPOSITORIES[g:PLUGIN_FZF]
  Plug g:REPOSITORIES[g:PLUGIN_FZF_VIM]

  " Key bindings {
    " Open splits
    nnoremap <space><C-H> :leftabove vsplit<CR>:Buffers<CR>
    nnoremap <space><C-J> :rightbelow split<CR>:Buffers<CR>
    nnoremap <space><C-K> :leftabove split<CR>:Buffers<CR>
    nnoremap <space><C-L> :rightbelow vsplit<CR>:Buffers<CR>

    " Search through the lines of the currently open buffers.
    nnoremap <Bslash><Bslash> :Lines<CR>

    " Search through the path with the word under the cursor.
    nnoremap <Bslash>w :Rg <C-R>=expand("<cword>")<CR><CR>

    " Gather all the to-dos within the path in the quickfix window.
    nnoremap <Bslash>t :cgetexpr system('rg --vimgrep TODO .')<CR>:copen<CR>

    " Search through the currently open buffers.
    nnoremap <Bslash>b :Buffers<CR>

    " Search through the path for a specific file by name.
    nnoremap <Bslash>f :Files<CR>

    " Search through the path with a pattern to open a file on a specific line.
    nnoremap <Bslash>r :Rg<CR>

    " Search through the file, command or search history.
    nnoremap <Bslash>h :History<CR>
    nnoremap <Bslash>: :History:<CR>
    nnoremap <Bslash>/ :History/<CR>
  " }

  return 1
endfunction
