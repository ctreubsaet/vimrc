" Highlight the column at 80 characters.
setlocal colorcolumn=80

if (g:AVAILABLE_PLUGINS[g:PLUGIN_ALE])
  let b:ale_linters = [ 'flake8' ]
  let b:ale_fixers = [ 'black', 'isort' ]
endif
