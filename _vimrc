" vimの内部で使われる文字コードの指定
set encoding=utf-8


" for NeoBundle --------------------------------------------------
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

call neobundle#end()

" add plugins
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'gregsexton/gitv'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'thinca/vim-ref'
NeoBundle 'groenewege/vim-less'
" NeoBundle 'Shougo/vimproc.vim', {
" \ 'build' : {
" \     'windows' : 'tools\\update-dll-mingw',
" \     'cygwin' : 'make -f make_cygwin.mak',
" \     'mac' : 'make -f make_mac.mak',
" \     'linux' : 'make',
" \     'unix' : 'gmake',
" \    },
" \ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'thinca/vim-quickrun'
" ----------------------------------------------------------------

" add colorscheme
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'nanotech/jellybeans.vim'

" fot vim-gitgutter ----------------------------------------------
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'
" ----------------------------------------------------------------

" for lightline.vim ----------------------------------------------
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'separator': { 'left': '⮀', 'right': '⮂' },
        \ 'subseparator': { 'left': '⮁', 'right': '⮃'},
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
\ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : '⭤'
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" ----------------------------------------------------------------

autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd FileType markdown hi! def link markdownItalic LineNr

" [vimfiler - start]
" デフォルトファイルエクスプローラに指定
let g:vimfiler_as_default_explorer = 1
" セーフモードの無効化
let g:vimfiler_safe_mode_by_default = 0

let g:vim_markdown_initial_foldlevel=2

nnoremap <C-f> :VimFiler -split -simple -winwidth=35 -no-quit
" [vimfiler - end]

" for vim-coffee-script
" autocmd BufWritePost *.coffee silent CoffeeMake! -c | cwindow | redraw!

" for vim-less
autocmd BufNewFile,BufRead *.less set filetype=css

syntax enable
set t_Co=256
scriptencoding utf-8
filetype plugin on
set laststatus=2
if has('mouse')
  set mouse=a
  set ttymouse=xterm2
endif
" ファイルの文字コードの自動判別
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
set shortmess+=I
set nobackup
set foldlevel=2
set modifiable
set write
set number
set cursorline
set tabstop=2
set hlsearch
set laststatus=2
set ambiwidth=double
set noundofile
set noswapfile
colorscheme jellybeans

cd $HOME

" 
NeoBundleCheck
