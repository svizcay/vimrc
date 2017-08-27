" ==============================================================================
" README
" ==============================================================================
"
" PLUGINS
" * There are basically two plugins manager in vim: pathogen and vundle
"   I'm using pathogen here. To install pathogen, go to https://github.com/tpope/vim-pathogen
"   and copy the autoload folder into your .vim folder. Pathogen is going to
"   include automatically all plugins found in .vim/bundle folder.
" * To download the plugins, just run:
"   $ git submodule update --init --recursive
" * "execute pathogen#infect()" must be the first line in your .vimrc file.
" * current list of plugins:
"   + nerdtree : https://github.com/scrooloose/nerdtree
"   + vim-airline : https://github.com/vim-airline/vim-airline
"   + vim-glsl : https://github.com/tikhomirov/vim-glsl
"   + html5-vim : https://github.com/othree/html5.vim
"
"
" MY NOTES ABOUT VIM
"   OPTIONS AND VARIABLES
" * "set" list all options that have a value other than the default one.
" * "set <option>?" shows the current value for that option.
"   Same as "echo &<option>"
" * Vim's options are set with "set" and variables are set with "let".
"   DISPLAY VIM VERSION AND DIRECTORIES
" * Use "echo $HOME", "echo $VIM" and "version"
" * Execute or reload a vim file "source <vimFile>" (or "so %" for current file)
"   MAPPINGS
" * remap (recursive mapping) is an OPTION! (a boolean option). It is not a type of mapping!
" * There are two types: map (recursive) and noremap (non-recursive). Each map
"   can be used in any mode (normal, visual, select, operator)
"   example: vnoremap is a non-recursive mapping used in visual mode
"
"   CTAGS
" * Execute ctags in the root directory of the project
"   $ ctags -R .
"   USAGE:
"       * CTRL+]    :   go to the definition of the tag underneath
"       * ts <tag>  : search a particular tag
"       * tn        : jump to next definition
"       * tp        : jump to the previous definition
"       * ts        : list all definitions of the last tag
"       * CTRL+t    :   jump back up in the tag stack
"
"   CSCOPE
" * Execute cscope to create the database
"   $ cscope -R -b  "-R (recursive) -b (build database only and exit)
" * Add databse to vim instance
"   :cs add <cscope.out>
"   USAGE:
"       * cs find s <symbolToLookFor>   : find this symbol
"       * cs find c <symbolToLookFor>   : find functions calling this function
"       * cs find d <symbolToLookFor>   : find functions called by this one
"       * cs find g <symbolToLookFor>   : find this definition
"       * cs find f <symbolToLookFor>   : find this file
"       * cs find i <symbolToLookFor>   : find files including this file
"       * cs find e <symbolToLookFor>   : find this egrep pattern
"       * cs find t <symbolToLookFor>   : find this text string


" ==============================================================================
" GENERAL SETTINGS
" ==============================================================================
execute pathogen#infect()

filetype plugin indent on

" enable 
syntax on

" display line numbers
set number

" backspace mode 2: indent,eol,start.
" it allows you to erease characters beyond the cursor position.
set backspace=2 

" set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
set fileencoding=utf8

" use Unix as the standard file type
set ffs=unix,dos,mac

" always show the status line
set laststatus=2

" format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" remember info about open buffers on close (search and command line history,
" etc)
set viminfo^=%

" delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" number of colors to use
set t_Co=256    

" theme
colorscheme molokai

" draw vertical line. value can use textwidth as reference with cc=+n
set colorcolumn=81

" set to auto read when a file is changed from the outside
" only works in graphical vim
set autoread

" add a bit extra margin to the left
set foldcolumn=1

" set nr padding lines when scrolling
set scrolloff=7

" height of the command bar
set cmdheight=2

" ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" always show current position (row, col)
set ruler

" in many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" show matching brackets when text indicator is over them
set showmatch 

" how many tenths of a second to blink when matching brackets
set mat=2

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" keep visual selection
vnoremap < <gv
vnoremap > >gv

" easytags
set tags=./tags,tags;/

" set current directory as the working one
autocmd BufEnter * lcd %:p:h
" if the previous command does not work use the next one
set autochdir

" ==============================================================================
" SEARCH SETTINGS
" ==============================================================================

" ignore case when searching
set ignorecase

" when searching try to be smart about cases
set smartcase

" highlight search results
set hlsearch

" makes search act like search in modern browsers
set incsearch 
""""""""""""""""""""""""""""""""""""""""""""""""""

" for regular expressions turn magic on
set magic

" ==============================================================================
" SPLITS
" ==============================================================================

" move between them
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

" new splits below and right
set splitbelow
set splitright

" ==============================================================================
" INDENTING SETTINGS (TODO: MAKE SURE THIS SETTING WORKS FOR ALMOST EVERYTHING)
" ==============================================================================

set expandtab
" set textwidth=79
set textwidth=0
set nowrap
set tabstop=8
set softtabstop=4
set shiftwidth=4
set autoindent

" ==============================================================================
" CSCOPE
" ==============================================================================

if has("cscope")
    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  

    " shortcuts to look for the word under the cursor position
    " Ctrl + \ <option>
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

endif

" ==============================================================================
" CPP SETTINGS
" ==============================================================================

" create a template header file in hpp files
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

" ==============================================================================
" PLUGINS SETTINGS
" ==============================================================================

" ==============================================================================
" NERDTREE
" ==============================================================================

" start nerdtree automatically
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endinf

" shortcut to open nerdtree
map <C-n> :NERDTreeToggle<CR>

" close vim if only window left is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" set nerd tree arrow keys (utf-8 must be enabled)
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
