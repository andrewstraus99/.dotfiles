set nocompatible	        " disable compatibility to old vi
set showmatch		        " show matching
set ignorecase		        " case insensitive
set mouse=a		            " middle-click paste
set hlsearch		        " highlight search
set incsearch 		        " incremental search
set tabstop=4		        " number of columns occupied by a tab
set expandtab		        " converts tabs to white space
set shiftwidth=4	        " width for autoindents
set autoindent		        " indents a new line the same as previous
set number		            " adds line numbers
set ruler                   " makes lines relative
set wildmode=longest,list	" get bash-like tab completions
set cc=80		            " set an 80 column border

filetype plugin indent on 	"allow auto-indenting depending on filetype
syntax on		            " syntax highlighting
set clipboard=unnamedplus	"use system clipboard
set cursorline		        " highlight line of cursor
set ttyfast		            " speed up scrolling in vim

" disable backup files
 set nobackup
 set nowritebackup

" Automatically installs VimPlug!! 
" from: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
  if empty(glob(data_dir . '/autoload/plug.vim'))
      silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif 

" plugins!!!
call plug#begin()
    " GUI UPDATES
    " airline status bar
    Plug 'itchyny/lightline.vim'
    " highlights yanked lines
    Plug 'machakann/vim-highlightedyank'
    " ale linter
    Plug 'dense-analysis/ale'
    Plug 'vim-syntastic/syntastic'

    " Fuzzy finder
    Plug 'airblade/vim-rooter'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " gruvbox theme
    Plug 'morhetz/gruvbox'

    " ncm2 autocomplete
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    " NOTE: you need to install completion sources to get completions. Check
    " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'

    " C/C++
    Plug 'jackguo380/vim-lsp-cxx-highlight'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'rhysd/vim-clang-format'

    " Rust
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
    " (Optional) Multi-entry selection UI.
    Plug 'junegunn/fzf'
    Plug 'rust-lang/rust.vim'
call plug#end()

" ---------------- THEMES -----------------
" vim theme
set background=dark
colorscheme gruvbox
" set lightline theme
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


" ---------------- NCM2 --------------------
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect


" Language client for each language
let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ }

" Ale settings
let g:ale_linters = {'rust': ['analyzer']}

" ---------------- Keybinds ----------------
" rebind \s to use fzf
nnoremap <Leader>s :<C-u>Files<CR>

