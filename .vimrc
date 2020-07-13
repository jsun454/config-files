" Visual setup
colo ron
syn on
set nu
set cul
hi CursorLine cterm=none
hi CursorLineNr cterm=bold

" Tab completion
set wmnu 
set wim=longest:full,full 

" Tabs and spaces
set ts=4 
set sts=4 
set sw=4 
set et 

" Status line
set ls=2 
set nosmd 

" Line wrapping
" Vim sets the text width to 78 for vim-file comments, run `:verbose set tw?` to view the source
set nowrap
set ss=5
set lbr
nmap k gk
nmap j gj
nmap <Up> g<Up>
nmap <Down> g<Down>

" Tentative
set hi=500
set bo=all 
set mouse=a
"set lz

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" :PlugInstall
call plug#begin('~/.vim/vim_plug')

Plug 'itchyny/lightline.vim' 
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" This needs to load after lightline.vim and NERDTree, and it also requires the terminal to be using a Nerd Font
" For MacOS, install using `brew tap homebrew/cask-fonts && brew cask install <some-nerd-font>`
" Link: https://github.com/Homebrew/homebrew-cask-fonts
Plug 'ryanoasis/vim-devicons'

call plug#end()

" lightline.vim
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

" NERDTree
map <C-o> :NERDTreeToggle<CR>
let s:beige = "F5C06F"
let s:blue = "689FB6"
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:WebDevIconsDefaultFolderSymbolColor = s:beige 
let g:WebDevIconsDefaultFileSymbolColor = s:blue
