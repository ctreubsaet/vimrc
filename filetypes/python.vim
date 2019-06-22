"
"                                  _    _
"                                 | |  | |
"                    _ __   _   _ | |_ | |__    ___   _ __
"                   | '_ \ | | | || __|| '_ \  / _ \ | '_ \
"                   | |_) || |_| || |_ | | | || (_) || | | |
"                   | .__/  \__, | \__||_| |_| \___/ |_| |_|
"                   | |      __/ |
"                   |_|     |___/
"
"
" Author: Christiaan Reubsaet
" Github: https://github.com/ctreubsaet

" +----------------------------------------------------------------------------+
" |                             CONFIGURATION                                  |
" +----------------------------------------------------------------------------+

function! s:python_settings()
  " Enable proper indention.
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal shiftwidth=4

  " Highlight the column at 80 characters.
  setlocal colorcolumn=80
endfunction

autocmd! BufEnter *.py call s:python_settings()
