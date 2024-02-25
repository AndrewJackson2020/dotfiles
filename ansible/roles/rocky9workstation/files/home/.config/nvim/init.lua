-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  transparent = true, -- Enable this to disable setting the background color
  styles = {
     sidebars = "transparent",
     floats = "transparent",
  }
})
vim.cmd [[colorscheme tokyonight]]

require("nvim-tree").setup()
require("mason").setup()

require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "ruff_lsp"},
}

vim.opt.number = true
vim.opt.relativenumber = true

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
  }

  -- Plugins can have post-install/update hooks
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
 
  use {
    'nvim-tree/nvim-tree.lua',
     requires = {
       'nvim-tree/nvim-web-devicons',
     },
  }
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use	{
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  }

end)

