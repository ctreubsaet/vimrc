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
"     * check if the necessary packages are installed.
"     * automatically installs plug.vim and plugins.
"     * uses FZF for easier handling of files and buffers.
"     * uses UltiSnips for code snippets.
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
" |                              REQUIREMENTS                                  |
" +----------------------------------------------------------------------------+

function! s:checkRequiredVersion()
  if version < 800
    echo 'The required version is 800 or higher.'
  endif
endfunction

function! s:showMissingPackages()
  let MISSING = []

  if !(executable('curl'))
    call add(MISSING, 'No automatic plugin installation.')
  endif

  if !(executable('fzf'))
    call add(MISSING, 'No fzf commands.')
  endif

  if !(executable('rg'))
    call add(MISSING, 'No ripgrep commands.')
  endif

  if !(has('python3'))
    call add(MISSING, 'No UltiSnips functionality.')
  endif

  if len(MISSING)
    echo MISSING
  endif
endfunction

autocmd VimEnter * call s:showMissingPackages()
autocmd VimEnter * call s:checkRequiredVersion()

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
set sessionoptions=buffers          " only save the buffers of a session

" Macros
set lazyredraw                      " don't redraw while executing macro

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

  if has('python3')
    " UltiSnips is a framework for code snippets.
    Plug PLUGIN_ULTISNIPS
    " vim-snippets is a community-maintained repository of common code snippets.
    Plug PLUGIN_SNIPPETS

    " Note: The UltiSnips plugin requires the absolute path to the personal snippet directory.
    " Note: The UltiSnips plugin has reserved the directory name 'snippets' for its own usage,
    "       so I named the personal snippet directory to 'snippers'.
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

" PLUGIN_LIMELIGHT {
  " Set colors if colorscheme is unsupported.
  let g:limelight_conceal_ctermfg = 'gray'
  let g:limelight_conceal_ctermfg = 240
" }

" +----------------------------------------------------------------------------+
" |                               SHORTCUTS                                    |
" +----------------------------------------------------------------------------+

let mapleader = ' '

" Vim {
  " Open the vimrc file.
  nnoremap <leader>vv :e $MYVIMRC<CR>

  " Reload the vimrc file.
  nnoremap <leader>vr :source $MYVIMRC<CR>
" }

" Windows {
  " Navigate splits
  nnoremap <C-H> <C-W><C-H>
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>

  " Arrange splits
  nnoremap <leader><C-H> <C-W><S-H>
  nnoremap <leader><C-J> <C-W><S-J>
  nnoremap <leader><C-K> <C-W><S-K>
  nnoremap <leader><C-L> <C-W><S-L>

  " Open splits
  nnoremap <leader><S-H> :leftabove vnew<CR>
  nnoremap <leader><S-J> :rightbelow new<CR>
  nnoremap <leader><S-K> :leftabove new<CR>
  nnoremap <leader><S-L> :rightbelow vnew<CR>
" }

" Buffers {
  " Navigate buffers
  nnoremap [b :bprevious<CR>
  nnoremap ]b :bnext<CR>

  " Jumplist
  nnoremap [j <C-O>zz
  nnoremap ]j <C-I>zz

  " Changelist
  nnoremap [c g;zz
  nnoremap ]c g,zz
" }

" Editor {
  " Autocomplete
  inoremap ;; <C-X><C-N>

  " Macros
  nnoremap Q @@

  " Spellchecker {
      " Toggle spellchecker.
      nnoremap <leader>p :setlocal spell!<CR>

      " Quickly fix a misspelled word.
      nnoremap <leader>z z=1<CR><CR>
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
    nnoremap <silent> <leader><CR> :noh<CR>
  " }

  " Text manipulation {
    " Move current line up or down in normal mode.
    nnoremap [w :m .-2<CR>==
    nnoremap ]w :m .+1<CR>==

    " Move selected lines up or down in visual mode.
    vnoremap [w :m '<-2<CR>gv=gv
    vnoremap ]w :m '>+1<CR>gv=gv
" }

" Sessions {
  " Look up and load a previously saved session.
  nnoremap <leader>sl :source <C-R>=DIRECTORY_SESSIONS . '/*'<CR>

  " Save a session.
  nnoremap <leader>ss :mksession! <C-R>=DIRECTORY_SESSIONS . '/'<CR>
" }

" Path {
  " Set the working directory to the one of the current file.
  nnoremap ,s :cd %:p:h<CR>:pwd<CR>

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

    " Search through the path for a specfic file.
    nnoremap <Bslash>f :Files<CR>

    " Search through the path for a specific line of text.
    nnoremap <Bslash>r :Rg<CR>

    " Gather all the to-dos within the path in the quickfix window.
    nnoremap <Bslash>t :cgetexpr system('rg --vimgrep TODO .')<CR>:copen<CR>

    nnoremap <Bslash>b :Buffers<CR>
    nnoremap <Bslash>h :History<CR>
    nnoremap <Bslash>: :History:<CR>
    nnoremap <Bslash>/ :History/<CR>
  " }

  " PLUGIN_ULTISNIPS {
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
  " }

  " PLUGIN_GOYO {
    nnoremap <leader>g :Goyo<CR>
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
