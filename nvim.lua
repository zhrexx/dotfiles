-- Packer: git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- Packer | Plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'nvim-treesitter/nvim-treesitter'
  use 'kyazdani42/nvim-tree.lua'
  use 'projekt0n/github-nvim-theme'
  use 'karb94/neoscroll.nvim'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- themes
  use { "catppuccin/nvim", as = "catppuccin" }
  use { 'rose-pine/neovim', as = 'rose-pine' }
end)

local lspconfig = require('lspconfig')

lspconfig.clangd.setup {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
}

local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

vim.api.nvim_create_user_command('Tmp', function()
  vim.cmd.edit('/tmp/temp')
end, {})


require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "cpp" },
  highlight = { enable = true },
}

require('nvim-tree').setup({
  open_on_tab = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },

  view = {
    side = 'left',
    width = 31,
  },
})

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    transparent_background = false,
    term_colors = true,
    integrations = {
        treesitter = true,
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
    }
})

require('rose-pine').setup({
    variant = 'moon', -- 'main', 'moon', or 'dawn'
    dark_variant = 'main',
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = false,
    disable_italics = false,
})

require('neoscroll').setup()

local ls = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()

-- GOTO config
vim.cmd.colorscheme "catppuccin"

-- opt
vim.opt.syntax = "on"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.updatetime = 300

-- o
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true 

-- Keymap
vim.api.nvim_set_keymap('i', '<C-w>', 'lua require("cmp").mapping.confirm({ select = true })', { noremap = true, silent = true })
vim.api.nvim_set_keymap('s', '<C-e>s', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", function() ls.expand_or_jump() end, {silent = true})

-- Other
vim.g.mapleader = 'C-'


