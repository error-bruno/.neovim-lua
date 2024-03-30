return {
	"shaunsingh/nord.nvim",
	name = "nord",
	config = function() end,
	init = function()
		vim.g.nord_contrast = true
		vim.g.nord_borders = false
		vim.g.nord_cursorline_transparent = true
		vim.g.nord_disable_background = true
		vim.g.nord_italic = true
		vim.g.nord_uniform_diff_background = true
		vim.g.nord_bold = false

		vim.cmd("colorscheme nord")
	end,
}
