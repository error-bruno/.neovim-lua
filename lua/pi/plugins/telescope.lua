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

local m = require("pi/utils").lazy_map
local keys = {
	m("<leader>pf", [[TelescopeFindFiles]]),
	m("<C-p>", [[TelescopeGitFiles]]),
	m("<leader>fb", [[TelescopeBuffers]]),
	m("<leader>ps", [[TelescopeGrepString]]),
}

return {
	"nvim-telescope/telescope.nvim",
	config = config,
	init = function()
		local builtin = require("telescope.builtin")
		local create_cmd = require("pi/utils").create_cmd
		create_cmd("TelescopeFindFiles", builtin.find_files)
		create_cmd("TelescopeOldFiles", builtin.oldfiles)
		create_cmd("TelescopeGitFiles", builtin.git_files)
		create_cmd("TelescopeBuffers", builtin.buffers)
		create_cmd("TelescopeGrepString", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end,
	cmd = "Telescope",
	keys = keys,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
