local logo = [[
                                             
      ████ ██████           █████      ██
     ███████████             █████ 
     █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████
]]

return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		opts = function()
			local cmd_string = require("pi/utils").cmd_string
			local dashboard = require("alpha.themes.dashboard")
			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("f", " " .. " Find file", cmd_string([[TelescopeFindFiles]])),
				dashboard.button("r", " " .. " Recent files", cmd_string([[TelescopeOldFiles]])),
				dashboard.button("g", " " .. " Find text", cmd_string([[TelescopeGrepString]])),
				dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.opts.layout[1].val = 6
			return dashboard
		end,
		config = function(_, dashboard)
			require("alpha").setup(dashboard.opts)
			vim.api.nvim_create_autocmd("User", {
				callback = function()
					local date = os.date("  %m/%d/%Y ")
					local time = os.date("  %H:%M:%S ")
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime * 100) / 100
					local plugin = "  "
						.. stats.loaded
						.. "("
						.. stats.count
						.. ")"
						.. " plugins 󱐌 "
						.. ms
						.. " ms "
					local v = vim.version()
					local version = "  v" .. v.major .. "." .. v.minor .. "." .. v.patch
					dashboard.section.footer.val = date .. time .. plugin .. version
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
}
