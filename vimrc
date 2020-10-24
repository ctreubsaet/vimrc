"
"
"                  ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"                  ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"                  ██║   ██║██║██╔████╔██║██████╔╝██║
"                  ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                   ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                    ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
"
" Author: Christiaan Reubsaet
" Github: https://github.com/ctreubsaet
"
" Description:
"   This vimrc is primarily built for writing plain text and light scripting.
"
"   The vimrc contains the following features:
"     * checks if the necessary packages are installed.
"     * automatically installs plug.vim and the plugins.
"     * uses FZF for easier handling of files and buffers.
"     * uses ALE for linting and code formatting while you edit your text files.
"     * uses UltiSnips for snippets management and vim-snippets for community snippets.
"     * uses Goyo and Limelight to toggle a distraction-free environment.
"
" Sections:
"   -> REQUIREMENTS
"   -> VARIABLES
"   -> INSTALLATION
"   -> SETTINGS
"   -> EDITOR
"   -> PLUGINS
"   -> SHORTCUTS
"   -> APPEARANCE
"   -> VIMLOCAL

" +----------------------------------------------------------------------------+
" |                               VARIABLES                                    |
" +----------------------------------------------------------------------------+

let DIRECTORY_VIM = $HOME . '/' . '.vim'
let DIRECTORY_AUTOLOAD = DIRECTORY_VIM . '/' . 'autoload'
let DIRECTORY_PLUGINS = DIRECTORY_VIM . '/' . 'plugged'
let DIRECTORY_SNIPPETS = DIRECTORY_VIM . '/' . 'snippers'
let DIRECTORY_SESSIONS = DIRECTORY_VIM . '/' . 'sessions'
let DIRECTORY_COLORS = DIRECTORY_VIM . '/' . 'colors'

let PLUGIN_MANAGER_FILE = DIRECTORY_AUTOLOAD . '/' . 'plug.vim'
let PLUGIN_MANAGER_URL = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

let PLUGIN_FZF = $HOME . '/' . '.fzf'
let PLUGIN_FZF_VIM = 'junegunn/fzf.vim'
let PLUGIN_ALE = 'dense-analysis/ale'
let PLUGIN_ULTISNIPS = 'SirVer/ultisnips'
let PLUGIN_SNIPPETS = 'honza/vim-snippets'
let PLUGIN_GOYO = 'junegunn/goyo.vim'
let PLUGIN_LIMELIGHT = 'junegunn/limelight.vim'

let VIMLOCAL = $HOME . '/' . '.local.vim'

" +----------------------------------------------------------------------------+
" |                              INSTALLATION                                  |
" +----------------------------------------------------------------------------+

" Create the full directory structure.
let directories = [ DIRECTORY_AUTOLOAD, DIRECTORY_PLUGINS, DIRECTORY_SESSIONS, DIRECTORY_COLORS ]

for directory in directories
  if !(isdirectory(directory))
    call mkdir(directory, 'p')
  endif
endfor

" Download and install the plugin manager and the plugins.
if !(filereadable(PLUGIN_MANAGER_FILE)) && executable('curl')
  execute printf('!curl -fLo %s %s', PLUGIN_MANAGER_FILE, PLUGIN_MANAGER_URL)
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" +----------------------------------------------------------------------------+
" |                                SETTINGS                                    |
" +----------------------------------------------------------------------------+

" Encoding
set encoding=utf-8                  " the encoding used inside Vim
set fileencoding=utf-8              " the encoding written to the file
set termencoding=utf-8              " the encoding used for the terminal

" Files and buffers
set autoread                        " reload file when changed outside of Vim
set path=.,**                       " set directory path to current file
set hidden                          " hide buffer when abandoned
set nobackup                        " no backup when overwriting file
set nowritebackup                   " no backup when overwriting file
set noswapfile                      " disable swapfile for the buffer

" Wildmenu
set wildmenu                        " enable tab-completion menu for files and buffers
set wildcharm=<C-z>                 " enable tab-completion from a key mapping
set wildmode=longest:list,full      " open and expand wildmenu with longest match first
set wildignorecase                  " search matches are case insensitive
set wildignore+=*.pyc,*.class       " ignore compiled code
set wildignore+=*/.git/**/*         " ignore version control
set wildignore+=*.tar.*,*.zip       " ignore archives

" Registers
set clipboard=unnamed               " set unnamed register to system clipboard

" Dictionary
set complete+=k                     " enable dictionary completion

" Sessions
set sessionoptions=curdir,buffers   " only save the working directory and buffers

" Macros
set lazyredraw                      " don't redraw while executing a macro

" Statusline
set noshowmode                      " hide the current mode
set noshowcmd                       " hide the last command

" +----------------------------------------------------------------------------+
" |                                EDITOR                                      |
" +----------------------------------------------------------------------------+

" Line numbers
set relativenumber                  " show relative line numbers
set number                          " show current line number

" Splitting
set splitright                      " open a file in a right split
set splitbelow                      " open a file in a bottom split

" Searching
set incsearch                       " show search matches as you type
set hlsearch                        " highlight search matches
set ignorecase                      " search matches are case insensitive
set smartcase                       " search matches are case sensitive if any upper case

" Indentation
set autoindent                      " enable automatic indention
set expandtab                       " replace a tab with spaces
set tabstop=2                       " a tab is two spaces
set softtabstop=2                   " untab with two spaces
set shiftwidth=2                    " autoindent with two spaces

" Whitespace
set list                            " show whitespace characters
set listchars-=eol:$                " don't show the newline character
set listchars+=tab:>-               " show tabs and preserve their alignment
set listchars+=trail:-              " show trailing whitespace

" Code folding
set foldenable                      " enable code folding
set foldmethod=indent               " fold by indentation

" +----------------------------------------------------------------------------+
" |                                PLUGINS                                     |
" +----------------------------------------------------------------------------+

call plug#begin(DIRECTORY_PLUGINS)
  if executable('fzf') && executable('rg')
    " fzf is a command-line fuzzy finder with a plugin to integrate with Vim.
    Plug PLUGIN_FZF
    " fzf vim is a bundle of fzf-based commands and mappings.
    Plug PLUGIN_FZF_VIM

    " Note: The fzf plugin is already included in the fzf installation and referred
    "       from the home directory.
    " Note: The fzf vim plugin depends on the fzf plugin.
  endif

  if version >= 800
    " ALE provides linting and code formatting while you edit your text files.
    Plug PLUGIN_ALE

    " Note: The used linters and fixers for each filetype are defined separately
    "       in a ftplugin file.
  endif

  if has('python3')
    " UltiSnips is a framework for code snippets.
    Plug PLUGIN_ULTISNIPS
    " vim-snippets is a community-maintained repository of common code snippets.
    Plug PLUGIN_SNIPPETS

    " Note: The UltiSnips plugin requires the absolute path to the
    "       personal snippet directory
    " Note: The UltiSnips plugin has reserved the directory name 'snippets'
    "       for its own usage so I named the personal snippet directory to 'snippers'.
  endif

  " Goyo and Limelight create a distraction-free environment for writing text.
  Plug PLUGIN_GOYO | Plug PLUGIN_LIMELIGHT
call plug#end()

" PLUGIN_ULTISNIPS | PLUGIN_SNIPPETS {
  " Add the personal snippet directory.
  let g:UltiSnipsSnippetDir = DIRECTORY_SNIPPETS

  " Put priority of the personal snippets before those in PLUGIN_SNIPPETS.
  let g:UltiSnipsSnippetDirectories = [DIRECTORY_SNIPPETS, "UltiSnips"]

  " Open the UltiSnipsEdit in a vertical buffer.
  let g:UltiSnipsEditSplit = "vertical"
" }

" PLUGIN_ALE {
  " Only run the linters when you save a file.
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_lint_on_enter = 0
  let g:ale_lint_on_insert_leave = 0
" }

" PLUGIN_GOYO {
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

" +----------------------------------------------------------------------------+
" |                               SHORTCUTS                                    |
" +----------------------------------------------------------------------------+

" Vim {
  " Open the vimrc file.
  nnoremap <space>vv :e $MYVIMRC<CR>

  " Reload the vimrc file.
  nnoremap <space>vr :source $MYVIMRC<CR>
" }

" Windows {
  " Navigate splits
  nnoremap <C-H> <C-W><C-H>
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>

  " Open splits
  nnoremap <space><C-H> :leftabove vsplit<CR>:Buffers<CR>
  nnoremap <space><C-J> :rightbelow split<CR>:Buffers<CR>
  nnoremap <space><C-K> :leftabove split<CR>:Buffers<CR>
  nnoremap <space><C-L> :rightbelow vsplit<CR>:Buffers<CR>
" }

" Lists {
  " Buffers
  nnoremap [b :bprevious<CR>
  nnoremap ]b :bnext<CR>

  " Jumps
  nnoremap [j <C-O>zz
  nnoremap ]j <C-I>zz

  " Changes
  nnoremap [c g;zz
  nnoremap ]c g,zz
" }

" Editor {
  " Quickly save file.
  nnoremap <space><space> :w<CR>

  " Autocomplete
  inoremap ;; <C-X><C-N>

  " Macros
  nnoremap Q @@

  " Plain text {
    " Quickly fix a misspelled word.
    nnoremap <space>ww z=1<CR><CR>

    " Toggle the spellchecker.
    nnoremap <space>ws :setlocal spell!<CR>

    " Show the word count.
    nnoremap <space>wc g<C-g>
  " }

  " Searching {
    " Center the line while moving through the search result.
    nnoremap n nzz
    nnoremap N Nzz
    nnoremap * *zz
    nnoremap # #zz
    nnoremap g* g*zz
    nnoremap g# g#zz

    " Turn off search highlight.
    nnoremap <silent> <space><CR> :noh<CR>
  " }
" }

" Sessions {
  " Look up and load a previously saved session.
  nnoremap <space>sl :source <C-R>=DIRECTORY_SESSIONS . '/*'<CR>

  " Save a session.
  nnoremap <space>ss :mksession! <C-R>=DIRECTORY_SESSIONS . '/'<CR>
" }

" Path {
  " Set the working directory to the one of the current file.
  nnoremap ,/ :cd %:p:h<CR>:pwd<CR>

  " Set the working directory to its parent directory.
  nnoremap ,,/ :cd ..<CR>:pwd<CR>

  " Set the working directory to its grandparent directory.
  nnoremap ,,,/ :cd ../..<CR>:pwd<CR>

  " Copy the absolute path of the current file to the clipboard.
  nnoremap ,a :let @+=expand('%:p')<CR>

  " Copy the directory path of the current file to the clipboard.
  nnoremap ,d :let @+=expand('%:p:h')<CR>

  " Copy the name of the current file to the clipboard.
  nnoremap ,f :let @+=expand('%:t')<CR>
" }

" Plugins {
  " PLUGIN_FZF_VIM {
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

  " PLUGIN_ALE {
    " Apply the code formatter(s) on the buffer.
    nnoremap <space>a :ALEFix<CR>

    nmap <silent> [a <Plug>(ale_previous_wrap)zz
    nmap <silent> ]a <Plug>(ale_next_wrap)zz
  " }

  " PLUGIN_ULTISNIPS {
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
  " }

  " PLUGIN_GOYO {
    nnoremap <space>g :Goyo<CR>
  " }
" }

" +----------------------------------------------------------------------------+
" |                              APPEARANCE                                    |
" +----------------------------------------------------------------------------+

" Statusline {
  set laststatus=2                  " always show the statusline

  set statusline+=\ %f              " show current filename
  set statusline+=\ %m              " show modified flag
  set statusline+=\ %r              " show readonly flag
" }

" GUI {
  if has('gui_running')
  " Minimalize the GUI options.
    set guioptions-=m               " remove the menu bar
    set guioptions-=T               " remove the toolbar
    set guioptions-=L               " remove the left-hand scroll bar
    set guioptions-=l
    set guioptions-=R               " remove the right-hand scroll bar
    set guioptions-=r
  endif
" }

set shortmess+=F                    " hide file info while editing file
set shortmess+=I                    " hide the launch screen

" +----------------------------------------------------------------------------+
" +                                VIMLOCAL                                    +
" +----------------------------------------------------------------------------+

" Load the user-defined vim configuration.
if filereadable(VIMLOCAL)
  execute 'source ' . VIMLOCAL
endif
