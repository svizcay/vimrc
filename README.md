# instructions
================================

## linux

* clone repo into ~/.vim folder (remember to download submodules too)
```
$ git clone --recursive git@github.com:svizcay/vimrc.git ~/.vim
```

* create symbolic link in home directory
```
$ ln -s ~/.vim/.vimrc ~/.vimrc
```

## windows

* install gvim from vim.org (not from cygwin)
* use _vimrc filename rather than .vimrc
* use C:\users\<username> as home directory and not C:\Program Files\vim
* create folder C:\users\<username>\vimfiles that is going to be equivalent to ~/.vim
