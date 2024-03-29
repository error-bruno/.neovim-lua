return {
	--- Visuals
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	--
	--- LSP and code support
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			-- AI
			"zbirenbaum/copilot-cmp",
			-- Snippets
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
	},
	--
	--- Productivity enhancements
	"preservim/nerdcommenter",
	{
		"kylechui/nvim-surround",
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
		end,
	},
	--
}
