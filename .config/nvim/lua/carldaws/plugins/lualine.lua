return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-web-devicons" },
	opts = function()
		local simple_theme = {
			normal = {
				a = { fg = nil, bg = 1, gui = "bold" },
				b = { fg = nil, bg = nil },
				c = { fg = nil, bg = nil },
			},
			insert = {
				a = { fg = nil, bg = 1, gui = "bold" },
				b = { fg = nil, bg = nil },
				c = { fg = nil, bg = nil },
			},
			visual = {
				a = { fg = nil, bg = 1, gui = "bold" },
				b = { fg = nil, bg = nil },
				c = { fg = nil, bg = nil },
			},
			replace = {
				a = { fg = nil, bg = 1, gui = "bold" },
				b = { fg = nil, bg = nil },
				c = { fg = nil, bg = nil },
			},
			inactive = {
				a = { fg = nil, bg = 1, gui = "bold" },
				b = { fg = nil, bg = nil },
				c = { fg = nil, bg = nil },
			},
		}

		return {
			options = {
				theme = simple_theme
			}
		}
	end
}
