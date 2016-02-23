if exists('g:loaded_tohebi') || &cp
  finish
endif
let g:loaded_tohebi = 1

let s:default_patterns = ['.pylintrc']

" find the fallback globalrc
if !exists('g:tohebi_globalrc')

python << EOF
import vim
import os
home = os.path.expanduser("~")
globalrc = os.path.join(home, ".pylintrc")
if os.path.isfile:
    vim.command("let g:tohebi_globalrc = '%s'" % globalrc)
EOF

endif

if !exists('g:tohebi_patterns')
  let g:tohebi_patterns = s:default_patterns
endif
