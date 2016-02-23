if exists('g:loaded_pylintrc_discover') || &cp
  finish
endif
let g:loaded_pylintrc_discover = 1

let s:default_patterns = ['.pylintrc']

" find the fallback globalrc
if !exists('g:pylintrc_discover_globalrc')

python << EOF
import vim
import os
home = os.path.expanduser("~")
globalrc = os.path.join(home, ".pylintrc")
if os.path.isfile:
    vim.command("let g:pylintrc_discover_globalrc = '%s'" % globalrc)
EOF

endif

if !exists('g:pylintrc_discover_patterns')
  let g:pylintrc_discover_patterns = s:default_patterns
endif
