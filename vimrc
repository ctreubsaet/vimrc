"
"                              _
"                             (_)
"                      __   __ _  _ __ ___   _ __  ___
"                      \ \ / /| || '_ ` _ \ | '__|/ __|
"                       \ V / | || | | | | || |  | (__
"                        \_/  |_||_| |_| |_||_|   \___|
"
"
" Author: Christiaan Reubsaet
" Github: https://github.com/ctreubsaet
"
" Description:
"   This vimrc is primarily built for writing and organizing plain text.
"
"   The vimrc contains the following features:
"     * built to have a separate configuration for each filetype.
"     * easier handling of files and buffers.
"     * enables a personal wiki with markdown inside of Vim.
"     * boosts markdown editing with (simple) autocompletion and snippets.
"     * toggles a distraction-free environment.
"
" Sections:
"   -> VARIABLES
"   -> INSTALLATION
"   -> SETTINGS
"   -> EDITOR
"   -> PLUGINS
"   -> FILETYPES
"   -> DICTIONARIES
"   -> SHORTCUTS
"   -> APPEARANCE

set nocompatible

" +----------------------------------------------------------------------------+
" |                               VARIABLES                                    |
" +----------------------------------------------------------------------------+

let DIRECTORY_VIM = $HOME . '/' . '.vim'
let DIRECTORY_AUTOLOAD = DIRECTORY_VIM . '/' . 'autoload'
let DIRECTORY_PLUGINS = DIRECTORY_VIM . '/' . 'plugged'
let DIRECTORY_FILETYPES = DIRECTORY_VIM . '/' . 'filetypes'
let DIRECTORY_DICTIONARIES = DIRECTORY_VIM . '/' . 'dictionaries'
let DIRECTORY_SNIPPETS = DIRECTORY_VIM . '/' . 'snippers'
let DIRECTORY_SESSIONS = DIRECTORY_VIM . '/' . 'sessions'
let DIRECTORY_USER = DIRECTORY_VIM . '/' . 'user'
let DIRECTORY_COLORS = DIRECTORY_VIM . '/' . 'colors'

let FILE_PLUGIN_MANAGER = DIRECTORY_AUTOLOAD . '/' . 'plug.vim'
let FILE_COLORSCHEME = DIRECTORY_COLORS . '/' . 'zenburn.vim'
let FILE_WIKI = DIRECTORY_USER . '/' . 'wiki.vim'

let URL_PLUGIN_MANAGER = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
let URL_COLORSCHEME = 'https://raw.githubusercontent.com/jnurmine/zenburn/master/colors/zenburn.vim'

let PLUGIN_NERDTREE = 'scrooloose/nerdtree'
let PLUGIN_AIRLINE = 'vim-airline/vim-airline'
let PLUGIN_AIRLINE_THEMES = 'vim-airline/vim-airline-themes'
let PLUGIN_WIKI = 'vimwiki/vimwiki'
let PLUGIN_ULTISNIPS = 'SirVer/ultisnips'
let PLUGIN_SNIPPETS = 'honza/vim-snippets'
let PLUGIN_GOYO = 'junegunn/goyo.vim'
let PLUGIN_LIMELIGHT = 'junegunn/limelight.vim'

" Note: UltiSnips requires the absolute path to the personal snippet directory.
" Note: UltiSnips has reserved the name 'snippets' for its own usage, so I
"       named the directory 'snippers'.
" Note: FILE_WIKI contains the relative path to each wiki in an environmental variable.
"       These variables are defined in the .profile file of your home directory.

" +----------------------------------------------------------------------------+
" |                              INSTALLATION                                  |
" +----------------------------------------------------------------------------+

if has("unix")
  " Create the full directory structure.
  let directories = [ DIRECTORY_AUTOLOAD, DIRECTORY_PLUGINS, DIRECTORY_SESSIONS, DIRECTORY_COLORS ]

  for directory in directories
    if empty(glob(directory))
      call mkdir(directory, 'p')
    endif
  endfor

  " Download and install the plugin manager and the plugins.
  if empty(glob(FILE_PLUGIN_MANAGER))
    execute '!curl -fLo ' . FILE_PLUGIN_MANAGER . ' ' . URL_PLUGIN_MANAGER
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  " Download and install the color scheme.
  if empty(glob(FILE_COLORSCHEME))
    execute '!curl -fLo ' . FILE_COLORSCHEME . ' ' . URL_COLORSCHEME
  endif
endif

" Note: Curl is required to download the plugin manager and the colorscheme.
" Note: UltiSnips requires Python 3.x.

" +----------------------------------------------------------------------------+
" |                                SETTINGS                                    |
" +----------------------------------------------------------------------------+

" Encoding
set encoding=utf-8
set termencoding=utf-8

" Files and buffers
set autoread                        " reload file when changed outside of Vim
set path=.,**                       " set path to directory of current file
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
set sessionoptions=buffers          " only save the buffers of a session.

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
set shiftwidth=2                    " autoident with two spaces

" Code folding
set foldenable                      " enable code folding
set foldmethod=indent               " fold with indentation

" +----------------------------------------------------------------------------+
" |                                PLUGINS                                     |
" +----------------------------------------------------------------------------+

call plug#begin(DIRECTORY_PLUGINS)
  " NERDTree is a file system explorer for navigating and managing files.
  Plug PLUGIN_NERDTREE
  " vim-airline creates a more informative status line.
  Plug PLUGIN_AIRLINE | Plug PLUGIN_AIRLINE_THEMES
  " vimwiki creates a personal wiki and boosts the markdown editing inside of it.
  Plug PLUGIN_WIKI
  " UltiSnips is a framework for code snippets.
  Plug PLUGIN_ULTISNIPS
  " vim-snippets is a community-maintained repository of common code snippets.
  Plug PLUGIN_SNIPPETS
  " Goyo and Limelight create a distraction-free environment for writing text.
  Plug PLUGIN_GOYO | Plug PLUGIN_LIMELIGHT
call plug#end()

" PLUGIN_NERDTREE {
  "  Minimalize the UI of NERDTree.
  let g:NERDTreeMinimalUI = 1

  " Close NERDTree after opening a file.
  let g:NERDTreeQuitOnOpen = 1

  " Close the buffer when the file is deleted with NERDTree.
  let g:NERDTreeAutoDeleteBuffer = 1

  " Show hidden files by default.
  let g:NERDTreeShowHidden = 1
" }

" PLUGIN_AIRLINE | PLUGIN_AIRLINE_THEMES {
  " Always show the status line.
  set laststatus=2

  " Display current user and hostname.
  let g:airline_section_b = $USER . '@' . '%{hostname()}'
" }

" PLUGIN_WIKI {
  " Disable wiki functionality for regular markdown files.
  let g:vimwiki_global_ext = 0

  " Load the wiki from a user-defined file.
  function! s:loadWiki()
    let wiki = g:FILE_WIKI

    if filereadable(wiki)
      execute 'source ' . wiki
    endif
  endfunction

  call s:loadWiki()

" PLUGIN_ULTISNIPS | PLUGIN_SNIPPETS {
  " Add the personal snippet directory.
  let g:UltiSnipsSnippetDir = DIRECTORY_SNIPPETS

  " Put priority of the personal snippets before those in PLUGIN_SNIPPETS.
  let g:UltiSnipsSnippetDirectories = [DIRECTORY_SNIPPETS, "UltiSnips"]

  " Remove the <tab> mapping of PLUGIN_WIKI to not override the <tab> mapping of PLUGIN_ULTISNIPS.
  let g:vimwiki_table_mappings = 0

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
" |                               FILETYPES                                    |
" +----------------------------------------------------------------------------+

" Get the configuration of the current filetype.
function! s:getConfiguration()
  return g:DIRECTORY_FILETYPES . '/' . &filetype . '.vim'
endfunction

" Check and apply the configuration for the current filetype.
function! s:loadLocalConfiguration(configuration)
  if filereadable(a:configuration)
    execute 'source ' . a:configuration
  endif
endfunction

" When opening a file, load the configuration of its file type.
autocmd FileType * call s:loadLocalConfiguration(s:getConfiguration())

" +----------------------------------------------------------------------------+
" |                              DICTIONARIES                                  |
" +----------------------------------------------------------------------------+

" Get the dictionary of the current filetype.
function! s:getDictionary()
  return g:DIRECTORY_DICTIONARIES . '/' . &filetype . '.txt'
endfunction

" Check and apply the dictionary for the current filetype.
function! s:loadLocalDictionary(dictionary)
  if filereadable(a:dictionary)
    execute 'setlocal dict+=' . a:dictionary
  endif
endfunction

" When opening a file, load the dictionary of its file type.
autocmd FileType * call s:loadLocalDictionary(s:getDictionary())

" +----------------------------------------------------------------------------+
" |                               SHORTCUTS                                    |
" +----------------------------------------------------------------------------+

let mapleader=' ' " <space>

" File shortcuts {
  " Open the vimrc file.
  nnoremap <leader>cv :e $MYVIMRC<CR>

  " Reload the vimrc file.
  nnoremap <leader>cr :source $MYVIMRC<CR>

  " Open the configuration of the current filetype.
  autocmd BufEnter * execute 'nnoremap <leader>cf :vsplit ' . s:getConfiguration() . '<CR>'

  " Open the dictionary of the current filetype.
  autocmd BufEnter * execute 'nnoremap <leader>cd :vsplit ' . s:getDictionary() . '<CR>'
" }

" SETTINGS {
  " Files and buffers {
    " Navigate buffers
    nnoremap <leader>l :bnext<CR>
    nnoremap <leader>h :bprevious<CR>

    " Find files (with path)
    nnoremap <leader>f :find *
    nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>
    nnoremap <leader>s :sfind *
    nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
    nnoremap <leader>v :vert sfind *
    nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>

    " Find buffers (with wildcharm)
    nnoremap <leader>b :buffer <C-z><S-Tab>
    nnoremap <leader>B :vert sbuffer <C-z><S-Tab>
  " }

  " Registers
  nnoremap <leader>r :reg<cr>

  " Sessions {
    " Look up and load a previously saved session.
    nnoremap <leader>al :source <C-R>=DIRECTORY_SESSIONS.'/*'<CR>

    " Save a session.
    nnoremap <leader>as :mksession! <C-R>=DIRECTORY_SESSIONS.'/'<CR>
  " }
" }

" EDITOR {
  " Toggle spellchecker.
  nnoremap <leader>p :setlocal spell!<CR>

  " Turn off search highlight.
  nnoremap <silent> <leader><CR> :noh<CR>

  " Split navigation
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  " Autocomplete
  inoremap <C-f> <C-X><C-N>
" }

" PLUGINS {
  " PLUGIN_NERDTREE
  nnoremap <leader>n :NERDTreeToggle<CR>

  " PLUGIN_GOYO
  nnoremap <leader>g :Goyo<CR>

  " PLUGIN_ULTISNIPS {
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
  " }
" }

" +----------------------------------------------------------------------------+
" |                              APPEARANCE                                    |
" +----------------------------------------------------------------------------+

colors zenburn

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

set shortmess+=I                    " hide the launch screen
