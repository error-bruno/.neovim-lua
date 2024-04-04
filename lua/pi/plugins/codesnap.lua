return {
	"mistricky/codesnap.nvim",
	build = "make",
	config = function()
		require("codesnap").setup({
			save_path = "~/Downloads/codesnap/test.png",
			has_breadcrumbs = true,
			bg_theme = "sea",
			watermark = "ara.bruno",
		})
	end,
}
