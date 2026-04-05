" =========================
" PLUGIN SETUP
" =========================
call plug#begin('~/.local/share/nvim/plugged')

" Treesitter (syntax highlighting)
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP (C++ support)
Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

" Colorscheme
Plug 'folke/tokyonight.nvim'

" nvim-tree
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" Git diff helper plugin
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lua/plenary.nvim'

call plug#end()

" =========================
" GENERAL SETTINGS
" =========================
let mapleader = " "
set number
set relativenumber
syntax on

set sw=2

colorscheme tokyonight

" =========================
" PLUGIN CONFIG
" =========================

" Toggle file explorer
nnoremap <C-e> :NvimTreeToggle<CR>

" Focus explorer
nnoremap <leader>e :NvimTreeFocus<CR>

" Window navigation
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>

" Code editing helper
nnoremap <leader>d :lua vim.diagnostic.open_float()<CR>
nnoremap gd :lua vim.lsp.buf.definition()<CR>
nnoremap gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>a :lua vim.lsp.buf.code_action()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>

" Gitsigns navigation
nnoremap [c :lua require('gitsigns').next_hunk()<CR>
nnoremap ]c :lua require('gitsigns').prev_hunk()<CR>

" Preview changes
nnoremap <leader>hg :lua require('gitsigns').preview_hunk()<CR>

" Stage/reset
nnoremap <leader>hs :lua require('gitsigns').stage_hunk()<CR>
nnoremap <leader>hr :lua require('gitsigns').reset_hunk()<CR>

" C++ Code compilation
nnoremap <F5> :w<CR>:!g++ % -o %:r && ./%:r<CR>

" C++ (SDL) Code compilation
nnoremap <F6> :!mkdir -p build && g++ % -o build/ex -lSDL2 && ./build/ex<CR>

lua << EOF
-- Treesitter
local ok, ts = pcall(require, 'nvim-treesitter.configs')
if ok then
  ts.setup {
    ensure_installed = { "c", "cpp" },
    highlight = { enable = true },
  }
end

-- nvim tree
require("nvim-tree").setup()

-- LSP (clangd for C++)
vim.lsp.enable('clangd')

-- Autocomplete
local cmp = require'cmp'

-- gitsigns
require('gitsigns').setup()

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
  },
  sources = {
    { name = 'nvim_lsp' },
  }
})
EOF
