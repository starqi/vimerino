
" Vim/Neovim, all OS, no GUI

"--------------------------------------------------
" Auto install plugins, need bash
"--------------------------------------------------

if !has("unix")
  " Don't use vimfiles
  set rtp+=~/.vim
endif
let b:rtplocation=expand('~/.vim')
let b:baselocation=b:rtplocation . '/autoload'
let b:pluglocation=b:baselocation . '/plug.vim'
if !filereadable(b:pluglocation)
  " --create-dirs is broken
  execute '!mkdir -p ' . b:baselocation
  execute '!curl -fLo ' . b:pluglocation . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  echo 'Type :PlugInstall!'
endif

"--------------------------------------------------
" List of plugins
"--------------------------------------------------

call plug#begin(b:rtplocation . '/plugged')
Plug 'scrooloose/syntastic' " Syntax checking
if has("nvim") " Basic completion
  Plug 'Shougo/deoplete.nvim' 
else
  Plug 'Shougo/neocomplete.vim' 
endif
Plug 'bitc/vim-hdevtools' " For Haskell, also need separate install, also use hasktags
Plug 'scrooloose/nerdtree' " Folder trees
Plug 'Lokaltog/vim-easymotion' " Jump to letters
Plug 'msanders/snipmate.vim' " Snippets for all languages
Plug 'vim-scripts/YankRing.vim' " Loop through copy paste history
Plug 'bling/vim-airline' " Pretty status bar
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy search
Plug 'pangloss/vim-javascript' " Syntax
Plug 'mxw/vim-jsx' " Syntax
Plug 'neovimhaskell/haskell-vim' " Syntax
call plug#end()

"--------------------------------------------------
" Settings
"--------------------------------------------------

let mapleader = ',' " Prefix key for many commands
set encoding=utf-8   
colorscheme default " Good default terminal color

let g:yankring_history_file = '.my_yankring_history_file'
let g:jsx_ext_required = 0 " JSX highlighting for JS files

if has("nvim")
  " Exiting terminal insert mode
  tnoremap <Esc> <C-\><C-n>
endif

" Manual syntax checking
nnoremap <F2> :SyntasticCheck<CR>
nnoremap <Leader><F2> :SyntasticReset<CR>
" Clear highlighting
nnoremap <Leader>g :noh<CR>
" Pop up the error list when errors
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" Disable syntax check on save/open/etc
let g:syntastic_mode_map = {"mode": "passive", "active_filetypes": [], "passive_filetypes": []}

" Get type of expression in Haskell
au FileType haskell nnoremap <buffer> <F3> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <Leader><F3> :HdevtoolsClear<CR>

let g:deoplete#enable_at_startup = 1
set completeopt-=preview " Don't pop up previews

" Remove directory from buffer line names
let g:airline#extensions#tabline#fnamemod = ':t'

" Fuzzy file search, try to find project directory
let g:ctrlp_working_path_mode = 'ar'
let g:ctrlp_map = ''
nnoremap <leader>0 :CtrlP<CR>

" Change buffers, delete buffer
nnoremap <Leader>q :bp<CR>
nnoremap <Leader>e :bn<CR>
nnoremap <Leader>c :bp<CR>:bd#<CR>

" NERDTree
nnoremap <Leader>1 :NERDTreeFocus<CR>
filetype plugin indent on " Auto react to file type changes

" Show tabs, keys for switching between tabs
let g:airline#extensions#tabline#enabled = 1

" Enable syntax colors
syntax enable 

" Jump to a letter
map t <Plug>(easymotion-s)

set rnu nu " Relative line numbers for easy jump
set hidden  " New files don't need to be saved to browse another file...
set autochdir " Current folder matches current buffer
set autoindent " No magic BS indent, use last line's indent
set nowrap " No line wrap
set shortmess+=I guioptions-=m guioptions-=T " No start up screen, or menus
set hlsearch " Highlight search results
set laststatus=2 " Display toolbar
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab shiftround " Every tab everywhere is 2 spaces
set backspace=indent,eol,start " Stop preventing backspace in certain places
set foldmethod=indent foldlevel=99 " Easily collapse with z[OocR], don't collapse on start
au FileType * setlocal fo-=c fo-=r fo-=o " Stop comment formatting

" Temporary Eiffel formatting
au FileType eiffel setlocal tabstop=4 softtabstop=4 shiftwidth=4 syntax=off

