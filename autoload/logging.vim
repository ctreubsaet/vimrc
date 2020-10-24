
function logging#error(msg)
  echohl ErrorMsg
  echom a:msg
  echohl None
endfunction

function logging#warning(msg)
  echohl WarningMsg
  echom a:msg
  echohl None
endfunction

function logging#checkPlugins(plugins)
  for [plugin, enabled] in items(a:plugins)
    if !(enabled)
      call g:logging#warning(printf('[plugin] %s failed to load.', plugin))
    endif
  endfor
endfunction
