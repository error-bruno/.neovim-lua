-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.6',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({ 'rose-pine/neovim', as = 'rose-pine' })

  use( 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use( 'nvim-treesitter/playground' )

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment the two plugins below if you want to manage the language servers from neovim
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
  use({
    'kylechui/nvim-surround',
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        -- Examples to reference:
        --Old text                    Command         New text
        ----------------------------------------------------------------------------------
        --surr*ound_words             ysiw)           (surround_words)
        --*make strings               ys$"            "make strings"
        --[delete ar*ound me!]        ds]             delete around me!
        --remove <b>HTML t*ags</b>    dst             remove HTML tags
        --'change quot*es'            cs'"            "change quotes"
        --<b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
        --delete(functi*on calls)     dsf             function calls
      })
    end
  })
  use( 'mhartington/formatter.nvim' )
  use( 'github/copilot.vim' )
  use( 'preservim/nerdcommenter' )
  use( 'lewis6991/gitsigns.nvim' )
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use { 'f-person/git-blame.nvim' }
end)
