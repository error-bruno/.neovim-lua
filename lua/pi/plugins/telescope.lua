local config = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			vimgrep_arguments = {
				"ag",
				"--nocolor",
				"--noheading",
				"--numbers",
				"--column",
				"--smart-case",
				"--silent",
				"--vimgrep",
			},
		},
	})
end

local m = require("pi/utils")
local keys = {
	m.lazy_map("<leader>pf", [[TelescopeFindFiles]]),
	m.lazy_map("<C-p>", [[TelescopeGitFiles]]),
	m.lazy_map("<leader>fb", [[TelescopeBuffers]]),
	m.lazy_map("<leader>ps", [[TelescopeGrepString]]),
}

return {
	"nvim-telescope/telescope.nvim",
	config = config,
	init = function()
		local builtin = require("telescope.builtin")
		m.create_cmd("TelescopeFindFiles", builtin.find_files)
		m.create_cmd("TelescopeOldFiles", builtin.oldfiles)
		m.create_cmd("TelescopeGitFiles", builtin.git_files)
		m.create_cmd("TelescopeBuffers", builtin.buffers)
		m.create_cmd("TelescopeGrepString", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end,
	cmd = "Telescope",
	keys = keys,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
