" Visual setup
colo ron
syn on
set nu
set cul
set fillchars+=vert:│
hi CursorLine cterm=none
hi CursorLineNr cterm=bold
hi SignColumn ctermbg=none
hi VertSplit cterm=none
hi EndOfBuffer ctermfg=black

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
set nowrap
set ss=5
set lbr
nmap k gk
nmap j gj
nmap <Up> g<Up>
nmap <Down> g<Down>

" This should prevent Vim from setting the text width to 78 for Vimscript comments (if it still does, run `:verbose set tw?` to view the source)
aug comment_nowrap
  au!
  au BufWinEnter,BufNewFile * setlocal fo-=cro
aug END

" Tentative
set hi=500
set bo=all 
set mouse=a

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
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" This needs to load after lightline.vim and NERDTree, and it also requires the terminal to be using a Nerd Font
" For MacOS, install using `brew tap homebrew/cask-fonts && brew cask install <some-nerd-font>`
" Link: https://github.com/Homebrew/homebrew-cask-fonts
Plug 'ryanoasis/vim-devicons'

Plug 'wesQ3/vim-windowswap'

call plug#end()

" lightline.vim
let g:lightline = {
  \   'colorscheme': 'seoul256',
  \   'active': {
  \     'left': [['mode', 'paste'], ['readonly', 'filename']],
  \     'right': [['lineinfo'], ['percent'], ['linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok']]
  \   },
  \   'inactive': {
  \     'left': [['readonly', 'filename']],
  \     'right': [['lineinfo'], ['percent'], ['linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok']]
  \   },
  \   'component_function': {
  \     'readonly': 'LightlineReadonly',  
  \     'filename': 'LightlineFilename'
  \   },
  \   'component_expand' : {
  \     'linter_checking': 'lightline#ale#checking',
  \     'linter_warnings': 'lightline#ale#warnings',
  \     'linter_errors': 'lightline#ale#errors',
  \     'linter_ok': 'lightline#ale#ok'
  \   },
  \   'component_type': {
  \     'linter_errors': 'error'
  \   }
  \ }

function! LightlineReadonly()
  return &readonly ? 'READ-ONLY' : ''
endfunction

function! LightlineFilename()
  let l:filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let l:modified = &modified ? ' +' : ''
  return l:filename . l:modified
endfunction

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129"
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"

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

aug nerdtree
  au!
  au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
aug END

" ALE
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_sign_warning = '>>'
hi ALEError cterm=underline
hi ALEErrorSign ctermbg=darkred
hi ALEWarning cterm=underline
hi ALEWarningSign ctermbg=darkyellow

" gitgutter
let g:gitgutter_sign_column_always = 1
set ut=250
