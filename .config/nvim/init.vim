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
Plug 'morhetz/gruvbox'

" File Tree.
Plug 'kyazdani42/nvim-tree.lua'

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

" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'

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

" Icons!
Plug 'ryanoasis/vim-devicons'

Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'
call plug#end()

let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = "hard"
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1

syntax enable
set termguicolors
colorscheme gruvbox
set encoding=UTF-8

" map <C-e> :NERDTreeToggle<CR>
nnoremap <C-e> :NvimTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseAllButPinned<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent> <C-s>    :BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw :BufferOrderByWindowNumber<CR>
