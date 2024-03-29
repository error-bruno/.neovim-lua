local kind_icons = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}
local source_mapping = {
	nvim_lsp = "[LSP]",
	nvim_lua = "[LUA]",
	luasnip = "[SNIP]",
	buffer = "[BUF]",
	path = "[PATH]",
	treesitter = "[TREE]",
}

local config = function()
	local cmp_status_ok, cmp = pcall(require, "cmp")
	if not cmp_status_ok then
		return
	end
	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	local lspkind = require("lspkind")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")

	cmp.setup({
		snippet = {
			expand = function(args)
				vim.snippet.expand(args.body)
			end,
		},
		window = {
			documentation = cmp.config.window.bordered({
				winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
			}),
			completion = cmp.config.window.bordered({
				winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
			}),
		},
		--view = {
		--entries = { name = "custom", selection_order = "near_cursor" },
		--},
		mapping = cmp.mapping.preset.insert({
			-- `Enter` key to confirm completion
			["<CR>"] = cmp.mapping.confirm({ select = true }),

			-- Ctrl+Space to trigger completion menu
			-- Change the tab to ctrl j
			["<C-j>"] = cmp.mapping(function(fallback)
				--["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-k>"] = cmp.mapping(function()
				if cmp.visible() then
					cmp.select_prev_item()
				end
			end, { "i", "s" }),
		}),
		sources = {
			{
				name = "luasnip",
				group_index = 1,
				option = { use_show_condition = true },
				entry_filter = function()
					local context = require("cmp.config.context")
					return not context.in_treesitter_capture("string") and not context.in_syntax_group("String")
				end,
			},
			{
				name = "nvim_lsp",
				group_index = 2,
			},
			{
				name = "copilot",
				group_index = 2,
				option = { use_show_condition = true },
				entry_filter = function()
					return not vim.g.leetcode
				end,
			},
			{
				name = "nvim_lua",
				group_index = 3,
			},
			{
				name = "crates",
				group_index = 3,
			},
			{
				name = "treesitter",
				keyword_length = 4,
				group_index = 4,
			},
			{
				name = "path",
				keyword_length = 4,
				group_index = 4,
			},
			{
				name = "buffer",
				keyword_length = 3,
				group_index = 5,
				option = {
					get_bufnrs = function()
						local bufs = {}
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							bufs[vim.api.nvim_win_get_buf(win)] = true
						end
						return vim.tbl_keys(bufs)
					end,
				},
			},
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				ellipsis_char = "...",
				before = function(_, vim_item)
					return vim_item
				end,
				menu = source_mapping,
			}),
		},
		sorting = {
			priority_weight = 2,
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
	})
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return {
	"hrsh7th/nvim-cmp",
	config = config,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"ray-x/cmp-treesitter",
			"saadparwaiz1/cmp_luasnip",
		},
	},
}
