"This file is part of vim-tohebi.
"
"vim-tohebi is free software: you can redistribute it and/or modify
"it under the terms of the GNU General Public License as published by
"the Free Software Foundation, either version 3 of the License, or
"(at your option) any later version.
"
"vim-tohebi is distributed in the hope that it will be useful,
"but WITHOUT ANY WARRANTY; without even the implied warranty of
"MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"GNU General Public License for more details.
"
"You should have received a copy of the GNU General Public License
"along with vim-tohebi.  If not, see <http://www.gnu.org/licenses/>.
"
if exists('g:loaded_tohebi') || &cp
  finish
endif
let g:loaded_tohebi = 1

" projectroot#get returns nothing if no project is found
let s:project_root = projectroot#get()

" get the patterns
let s:default_patterns = ['.pylintrc']
if !exists('g:tohebi_patterns')
  let g:tohebi_patterns = s:default_patterns
endif


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


function! tohebi#getrc()

  " get the global rc if vim doesn't start in a project
  if s:project_root == ""
    return g:tohebi_globalrc
  else
    return s:getprojectrc()
  endif

endfunction

function! s:getprojectrc()
python << EOF
import vim
import os
import fnmatch

root = vim.eval('s:project_root')
patterns = vim.eval('g:tohebi_patterns')

# find the first file in the project root dir that matches any of the specified patterns
for pattern in patterns:
    for file in os.listdir(root):
        if fnmatch.fnmatch(file, pattern):
            rc = os.path.join(root, file)
            vim.command("let s:projectfile = '%s'" % rc)
            break
EOF

"fallback to the global if no file was found
if exists('s:projectfile')
  return s:projectfile
else
  return g:tohebi_globalrc
endif

endfunction
