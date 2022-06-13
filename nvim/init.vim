" space is my leader!
let mapleader = "\<Space>"

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

    " Fuzzy finder
    Plug 'airblade/vim-rooter'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " gruvbox theme
    Plug 'morhetz/gruvbox'

    " Semantic language support
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/lsp_extensions.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
    Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
    Plug 'hrsh7th/cmp-path', {'branch': 'main'}
    Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
    Plug 'ray-x/lsp_signature.nvim'

    " Only because nvim-cmp _requires_ snippets
    Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
    Plug 'hrsh7th/vim-vsnip'

    " --- Language Support ---
    " C/C++
    Plug 'rhysd/vim-clang-format'
    " Rust
    Plug 'rust-lang/rust.vim'
    Plug 'cespare/vim-toml'
    " md
    Plug 'plasticboy/vim-markdown'
call plug#end()

" ---------------- THEMES -----------------
" vim theme
set background=dark
colorscheme gruvbox
" set lightline theme
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" ---------------- Completion --------------
" Completion
" Better completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" ---------------- Keybinds ----------------
" rebind \s to use fzf
nnoremap <Leader>s :<C-u>Files<CR>
" rebind space to jump to previous buffer
nnoremap <leader>b :ls<cr>:b<space>
" leader w saves file
nnoremap <Leader>w :w<CR>
" visual line mode
nmap <Leader><Leader> V

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" ------- LSP configuration ---------
"https://rust-analyzer.github.io/manual.html#installation
lua << END
local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
  },
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      completion = {
	postfix = {
	  enable = false,
	},
      },
    },
  },
  capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
END

" Enable type inlay hints
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }
