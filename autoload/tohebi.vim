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

" TODO(rski) this needs to be discovered
let s:project_root = '.'

function! tohebi#getrc()
python << EOF
import vim
import os
import fnmatch

root = vim.eval('s:project_root')
patterns = vim.eval('g:tohebi_patterns')

# find the first file in the project root dir that matches any of the specified patterns
rc = vim.eval('g:tohebi_globalrc')
for pattern in patterns:
    for file in os.listdir(root):
        if fnmatch.fnmatch(file, pattern):
            rc = os.path.join(root, file)
            break

vim.command("let s:rc = '%s'" % rc)
EOF
return s:rc
endfunction
