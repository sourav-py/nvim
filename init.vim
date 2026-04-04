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

call plug#end()

" =========================
" GENERAL SETTINGS
" =========================
set number
set relativenumber
syntax on

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
