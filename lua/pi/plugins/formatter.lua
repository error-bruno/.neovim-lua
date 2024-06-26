-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
local config = function()
	local util = require("formatter.util")
	require("formatter").setup({
		-- Enable or disable logging
		logging = true,
		-- Set the log level
		log_level = vim.log.levels.WARN,
		-- All formatter configurations are opt-in
		filetype = {
			-- Formatter configurations for filetype "lua" go here
			-- and will be executed in order
			javascript = { require("formatter.filetypes.typescript").prettier },
			typescript = { require("formatter.filetypes.typescript").prettier },
			typescriptreact = { require("formatter.filetypes.typescript").prettier },
			python = { require("formatter.filetypes.python").black },
			go = { require("formatter.filetypes.go").goimports },
			lua = {
				require("formatter.filetypes.lua").stylua,
				function()
					return {
						exe = "npx @johnnymorganz/stylua-bin",
						args = {
							"--search-parent-directories",
							"--stdin-filepath",
							util.escape_path(util.get_current_buffer_file_path()),
							"--",
							"-",
						},
						stdin = true,
					}
				end,
			},

			-- Use the special "*" filetype for defining formatter configurations on
			-- any filetype
			["*"] = {
				-- "formatter.filetypes.any" defines default configurations for any
				-- filetype
				require("formatter.filetypes.any").remove_trailing_whitespace,
			},
		},
	})
end

return {
	"mhartington/formatter.nvim",
	config = config,
	init = function()
		-- Format on write
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", {
			group = "__formatter__",
			command = ":FormatWrite",
		})
	end,
}
