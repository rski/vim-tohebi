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

" get the home dir
python << EOF
import vim
import os
home = os.path.expanduser("~")
vim.command("let s:home = '%s'" % home)
EOF


function! tohebi#getrc()

  " get the global rc if vim doesn't start in a project
  if s:project_root == ""
    return s:FindRcInDir(s:home)
  else
    return s:FindRcInDir(s:project_root)
  endif

endfunction


function! s:FindRcInDir(dir)

python3 << EOF
import vim
import os
import fnmatch

dir = vim.eval('a:dir')
patterns = vim.eval('g:tohebi_patterns')

# find the first file in the project root dir that matches any of the specified patterns
for pattern in patterns:
    for file in os.listdir(dir):
        if fnmatch.fnmatch(file, pattern):
            rc = os.path.join(dir, file)
            vim.command("let s:rc = '%s'" % rc)
            break
EOF


if exists('s:rc') " try to return a config from this folder
  return s:rc
elseif a:dir !=# s:home " don't try to find the file in HOME if just looked for it
  return s:FindRcInDir(s:home)
else
  return ""
endif

endfunction
