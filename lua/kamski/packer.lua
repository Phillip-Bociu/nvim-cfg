-- Only required if you have packer configured as `opt`

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

use "rebelot/kanagawa.nvim"
use "luisiacc/handmade-hero-theme"

use {
	'nvim-telescope/telescope.nvim', tag = '0.1.3',
	requires = { {'nvim-lua/plenary.nvim'} }
}

use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

use 'nvim-lua/plenary.nvim'

use {
	'ThePrimeagen/harpoon',
	branch = "harpoon2",
	requires = { { 'nvim-lua/plenary.nvim' } },
}

use('mbbill/undotree')
use('tpope/vim-fugitive')
use 'andweeb/presence.nvim'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-vsnip'
use 'hrsh7th/vim-vsnip'

use {
  "ray-x/lsp_signature.nvim",
}

use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  requires = {
    --- Uncomment these if you want to manage LSP servers from neovim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- LSP Support
    {'neovim/nvim-lspconfig'},
    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
  }
}
-- These optional plugins should be loaded directly because of a bug in Packer lazy loading
use 'lewis6991/gitsigns.nvim' -- OPTIONAL: for git status
end)

