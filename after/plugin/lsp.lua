local lsp_zero = require("lsp-zero")

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

-- When lsp_zero attaches, set keymaps
lsp_zero.on_attach(function(_, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)

	-- Unsure what these do
	--vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	--vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	--vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	--vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	--vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	--vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end
local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

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
	view = {
		entries = { name = "custom", selection_order = "near_cursor" },
	},
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		-- Ctrl+Space to trigger completion menu
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("copilot.suggestion").is_visible() then
				require("copilot.suggestion").accept()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			end
		end, {
			"i",
			"s",
		}),
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
		},
		{
			name = "codeium",
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
		{
			name = "emoji",
			keyword_length = 2,
			group_index = 6,
		},
		{
			name = "nerdfont",
			keyword_length = 2,
			group_index = 6,
		},
	},
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
			-- Source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
			})[entry.source.name]
			return vim_item
		end,
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

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"gopls",
		"rust_analyzer",
		"pyright",
		"lua_ls",
	},
	handlers = {
		lsp_zero.default_setup,
		gopls = function()
			require("lspconfig").gopls.setup({
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						gofumpt = true,
					},
				},
			})
		end,
		lua_ls = function()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},
})
