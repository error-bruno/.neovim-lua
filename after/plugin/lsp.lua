local lsp_zero = require("lsp-zero")
local m = require("pi/utils")
local create_cmd = m.create_cmd
local lazy_map = m.lazy_map

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
