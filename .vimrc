colo ron
set nu
syn on
set wildmenu
set wildmode=longest:full,full
set hi=100
set tabstop=4
set expandtab
set shiftwidth=4
set laststatus=2
set noshowmode

" Honestly not sure if I prefer this
set mouse=a

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" :PlugInstall
call plug#begin('~/.vim/vim_plug')
Plug 'itchyny/lightline.vim' 
Plug 'terryma/vim-multiple-cursors'
call plug#end()

let g:lightline = {
  \   'colorscheme': 'seoul256',
  \   'active': {
  \     'left': [['mode', 'paste'], ['readonly', 'filename']],
  \     'right': [['lineinfo'], ['percent']]
  \   },
  \   'inactive': {
  \     'left': [['readonly', 'filename']],
  \     'right': [['lineinfo'], ['percent']]
  \   },
  \   'component_function': {
  \     'readonly': 'LightlineReadonly',  
  \     'filename': 'LightlineFilename'
  \   }
  \ }

function! LightlineReadonly()
  return &readonly ? 'READ-ONLY' : ''
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
