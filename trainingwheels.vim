" Fork of sensible.vim to make vim more friendly to new users
" Forked by Daniel Noland
"
" TRUNK:
" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.1

" This is essential!
set encoding=utf-8
set termencoding=utf-8

" This is reality so we may as well get used to it
set bg=dark

" Change this to what you like, but use a leader command
let g:mapleader = '\'

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

set incsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set laststatus=2
set ruler
set showcmd
set wildmenu

" Make spell checking less annoying
nnoremap zz z=

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags^=./tags;
endif

if &shell =~# 'fish$'
  set shell=/bin/bash
endif

set autoread
set fileformats+=mac

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

" vim:set ft=vim et sw=2:
set showmatch
set expandtab
set tabstop=3
set shiftwidth=3
set wildmenu
set wildmode=list:longest
set ignorecase
set smartcase
set title
set scrolloff=5
set backupdir=~/.vim-tmp,~/.tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,/var/tmp,/tmp
set backspace=indent,eol,start
set shortmess=atIWA
set timeoutlen=1200
set ttimeoutlen=100
" current directory is always matching the
" content of the active window
set autochdir
" remember some stuff after quiting vim:
" marks, registers, searches, buffer list
set viminfo='20,<50,s10,h,%
" Return to last edit position when opening files (You want this!)
augroup AfterRead
   autocmd!
   autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
augroup END
func! DeleteTrailingWS()
  let l:view = winsaveview()
  %s/\s\+$//ge
  call winrestview(l:view)
endfunc

" TODO: move these calls functions to ftplugin files
augroup TrailingWhiteSpace
   autocmd!
   autocmd BufWrite *.py :call DeleteTrailingWS()
   autocmd BufWrite *.java :call DeleteTrailingWS()
   autocmd BufWrite *.c :call DeleteTrailingWS()
   autocmd BufWrite *.cpp :call DeleteTrailingWS()
   autocmd BufWrite *.cxx :call DeleteTrailingWS()
   autocmd BufWrite *.h :call DeleteTrailingWS()
   autocmd BufWrite *.hh :call DeleteTrailingWS()
   autocmd BufWrite *.hpp :call DeleteTrailingWS()
   autocmd BufWrite *.hxx :call DeleteTrailingWS()
   autocmd BufWrite *.sh :call DeleteTrailingWS()
   autocmd BufWrite *.bash :call DeleteTrailingWS()
   autocmd BufWrite *.html :call DeleteTrailingWS()
   autocmd BufWrite *.shtml :call DeleteTrailingWS()
   autocmd BufWrite *.js :call DeleteTrailingWS()
   autocmd BufWrite *.latex :call DeleteTrailingWS()
   autocmd BufWrite *.tex :call DeleteTrailingWS()
   autocmd BufWrite *.zsh :call DeleteTrailingWS()
augroup END

" I really like this, but it is up to you.
" Uncomment if you like.
" Command mode mappings
" noremap J 5j
" noremap K 5k
" noremap H 5h
" noremap L 5l
" noremap <C-l> :w | bnext<CR>
" noremap <C-h> :w | bprevious<CR>

nnoremap <leader>p :setlocal paste!<CR>
set pastetoggle=<F10>
nnoremap <leader>s :setlocal spell!<CR>

" Simple script to toggle relative or abs line numbers
function! NumberToggle()
   if(&relativenumber == 1)
      set norelativenumber
      set number
   else
      set number
      set relativenumber
   endif
   call NumberFix()
endfunc
nnoremap <leader># :call NumberToggle()<cr>
function! NumberFix()
   if(&buftype=='nofile' || &buftype=='quickfix' || &buftype =='help' )
      set norelativenumber
      set nonumber
   endif
endfunc
" Automatically switch to abs line numbers when focus is lost
augroup LineNumberCorrection
   autocmd!
   autocmd FocusGained,BufEnter,WinEnter,InsertLeave * set number | set relativenumber 
   autocmd FocusLost,BufLeave,WinLeave,InsertEnter * set norelativenumber | set number 
   autocmd FocusLost,FocusGained,BufLeave,BufEnter,WinEnter,WinLeave * call NumberFix()
augroup END

" Persist undo
set undofile
" You need to run $ mkdir -p ~/.vim/undo
" or you will get errors
set undodir=$HOME/.vim/undo/
set undolevels=1000
set undoreload=1000

set showmode
