-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  use({
	  "nvim-treesitter/nvim-treesitter-textobjects",
	  after = "nvim-treesitter",
	  requires = "nvim-treesitter/nvim-treesitter",
  })

  use "rebelot/kanagawa.nvim"
  -- use 'Mofiqul/vscode.nvim'

  use {
	  "folke/which-key.nvim",
	  config = function()
		  vim.o.timeout = true
		  vim.o.timeoutlen = 300
		  require("which-key").setup {
			  -- your configuration comes here
			  -- or leave it empty to use the default settings
			  -- refer to the configuration section below
		  }
	  end
  }

  use "theprimeagen/harpoon"

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v2.x',
	  requires = {
			  -- LSP Support
			  {'neovim/nvim-lspconfig'},             -- Required
			  {                                      -- Optional
			  'williamboman/mason.nvim',
			  run = function()
				  pcall(vim.cmd, 'MasonUpdate')
			  end,
		  },
		  {'williamboman/mason-lspconfig.nvim'}, -- Optional

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},     -- Required
		  {'hrsh7th/cmp-nvim-lsp'}, -- Required
		  {'L3MON4D3/LuaSnip'},     -- Required
	  }
  }

end)

