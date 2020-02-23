" Highlight the column at 80 characters.
setlocal colorcolumn=80

" Fill the location list with a pylint report.
setlocal makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
setlocal errorformat=%f:%l:\ [%t]%m,%f:%l:%m
