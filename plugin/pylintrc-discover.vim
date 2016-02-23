if exists('g:loaded_pylint_discover') || &cp
  finish
endif
let g:loaded_pylint_discover = 1

if !exists('g:pylint_discover_globalrc')

python << EOF
import vim
import os
home = os.path.expanduser("~")
globalrc = os.path.join(home, ".pylintrc")
vim.command("let g:pylint_discover_globalrc = '%s'" % globalrc)
EOF

endif

echo g:pylint_discover_globalrc
