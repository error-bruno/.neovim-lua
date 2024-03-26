return {
  --- Visuals
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  --

  --- LSP and code support
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
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
  },
  --{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-treesitter/playground',
  'mhartington/formatter.nvim',
  --
  --- Productivity enhancements
  {'nvim-telescope/telescope.nvim', tag = '0.1.6', dependencies = {{'nvim-lua/plenary.nvim'}}},
  'preservim/nerdcommenter',
  'github/copilot.vim',
  {
    'kylechui/nvim-surround',
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
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
  },
  --

  --- git integration
  'lewis6991/gitsigns.nvim',
  'f-person/git-blame.nvim',
  --
}
