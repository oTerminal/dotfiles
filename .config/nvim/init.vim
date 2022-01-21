" Make the vim clipboard sync with the system clipboard.
set clipboard+=unnamedplus
" This is used so fancy stuff works!
set nocompatible
" Set terminal colour to 256 colours.
set t_Co=256
" Set tabs to 4 chars.
set tabstop=4
" Set the indentation level to 4 chars.
set shiftwidth=4
" Convert tabs to spaces.
set expandtab
" Show the current number line and all the lines relative to it.
set number relativenumber
" Automatically indent.
set autoindent
" Highlight all search matches.
set hlsearch
" Split below and to the right by default.
set splitbelow
set splitright
" Show invisible characters.
set hidden

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction


call plug#begin('~/.vim/plugged')

" Themes for Neovim.
Plug 'arcticicestudio/nord-vim'

" File Tree.
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Statusline.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Syntax Highlighting.
Plug 'justinmk/vim-syntax-extra'
Plug 'chr4/nginx.vim'
Plug 'cespare/vim-toml'
Plug 'ron-rs/ron.vim'
Plug 'arzg/vim-rust-syntax-ext'
Plug 'sheerun/vim-polyglot'
Plug 'Sirsireesh/vim-dlang-phobos-highlighter'
Plug 'vim-python/python-syntax'

" Autoformatting.
Plug 'Chiel92/vim-autoformat'

" Conquer of Completion (COC)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Asynchronous markdown viewer
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" Rust Lang Enhancer
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

" Indentation Lines
Plug 'Yggdroot/indentLine'
" ..
Plug 'skywind3000/asyncrun.vim'
call plug#end()

let g:airline_theme = 'nord'
let g:airline_powerline_fonts = 1
let g:nord_italic = 1

syntax enable
set termguicolors
colorscheme nord

map <C-e> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
