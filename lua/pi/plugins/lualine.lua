return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"shaunsingh/nord.nvim",
	},
	config = function()
		local git_blame = require("gitblame")
		local custom_fname = require("lualine.components.filename"):extend()
		local highlight = require("lualine.highlight")

		local named_colors = require("nord.named_colors")

		function custom_fname:init(options)
			custom_fname.super.init(self, options)
			self.status_colors = {
				saved = highlight.create_component_highlight_group(
					{ bg = named_colors.dark_gray },
					"filename_status_saved",
					self.options
				),
				modified = highlight.create_component_highlight_group(
					{ bg = named_colors.orange },
					"filename_status_modified",
					self.options
				),
			}
			if self.options.color == nil then
				self.options.color = ""
			end
		end

		function custom_fname:update_status()
			local data = custom_fname.super.update_status(self)
			data = highlight.component_format_highlight(
				vim.bo.modified and self.status_colors.modified or self.status_colors.saved
			) .. data
			return data
		end

		local circle_seperator = { left = "", right = "" }
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = "",
				section_separators = {},
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,

				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				-- Bottom left side
				lualine_a = { { "mode", separator = circle_seperator, right_padding = 2 } },
				lualine_b = { { "b:gitsigns_head", icon = "", separator = { right = "" } } },
				lualine_c = {
					{ custom_fname, path = 1, separator = { right = "▓▒░" } },
					{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
				},

				-- Bottom right side
				lualine_x = { "selectioncount" }, -- TODO: Find a more useful metric to display here
				lualine_y = { { "progress", separator = { left = "" } }, "searchcount" },
				lualine_z = { { "location", separator = circle_seperator } },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {
				lualine_a = {
					{
						"buffers",
						show_filename_only = true, -- Shows shortened relative path when set to false.
						hide_filename_extension = false, -- Hide filename extension when set to true.
						show_modified_status = true, -- Shows indicator when the buffer is modified.

						section_separators = { left = "", right = "" },
						component_separators = { left = "", right = "" },

						mode = 4, -- 0: Shows buffer name
						-- 1: Shows buffer index
						-- 2: Shows buffer name + buffer index
						-- 3: Shows buffer number
						-- 4: Shows buffer name + buffer number

						max_length = vim.o.columns * 3 / 3, -- Truncate component if its length is larger than the maximum length
						filetype_names = {
							TelescopePrompt = "Telescope",
							dashboard = "Dashboard",
							packer = "Packer",
							fzf = "FZF",
							alpha = "Alpha",
						}, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

						-- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
						use_mode_colors = false,

						symbols = {
							modified = " ●", -- Text to show when the buffer is modified
							alternate_file = "", -- Text to show to identify the alternate file
							directory = "", -- Text to show when the buffer is a directory
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {
					{ "diff", separator = { left = "" } },
				},
				lualine_z = {
					{ "''", separator = circle_seperator },
				},
			},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
	init = function() end,
}
