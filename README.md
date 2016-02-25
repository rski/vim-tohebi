# vim-tohebi

A vim plugin that finds the current project's configuration files.

## Getting started

Tohebi provides the `tohebi#getrc()` function, which returns the full path to the first file in the project's root that matches any pattern in a list of patterns. If no such file is found, it tries to find such a file in the home directory.

The pattern list is given in `g:tohebi_patterns`. By default tohebi looks for a `.pylintrc` file:

    g:tohebi_patterns = ['.pylintrc']
    
This variable can be set to any list of [python fnmatch patterns](https://docs.python.org/3/library/fnmatch.html):

    g:tohebi_patterns = ['.pylint*', '*pylint*']

Then, to get the first file that matches any of these patterns do:

    let g:pylintrc = togebi#getrc()

Note that `tohebi#getrc()` will return the first file that matches the first pattern. If no file matches the first pattern it will return the first file that matches the second, and so on. It will not return multiple files if more than one files match any of the patterns.

The real reason this plugin was written was to integrate it with syntastic:

    let g:syntastic_python_pylint_args = '--rcfile='. g:pylintrc

For an example of a real use of tohebi, see my [vimrc](https://github.com/rski/dotfiles/blob/master/nvim/init.vim)

## Installation

Requires [vim-projectroot](https://github.com/dbakker/vim-projectroot).

Installing with pathogen:

    cd ~/.vim/bundle
    git clone git@github.com:rski/vim-tohebi.git

Installing with [Vundle](https://github.com/VundleVim/Vundle.vim):

Add `Bundle 'rski/vim-tohebi'` to your `~/.vimrc` and then call `:BundleInstall`.
