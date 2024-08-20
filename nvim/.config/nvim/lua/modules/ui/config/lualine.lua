local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local setup = function()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			-- theme = "catppuccin",
			theme = "auto",
			component_separators = "|",
			section_separators = { left = "", right = "" },
			disabled_filetypes = {},
			always_divide_middle = false,
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "", right = "" }, right_padding = 2 },
			},
			lualine_b = {
				{ "b:gitsigns_head", icon = "" },
				{ "diff", source = diff_source },
				"diagnostics",
			},
			lualine_c = {
				{ "filename", path = 3 },
			},
			lualine_x = {
				-- {
				-- 	require("noice").api.statusline.mode.get,
				-- 	cond = require("noice").api.statusline.mode.has,
				-- 	color = { fg = "#ff9e64" },
				-- },
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
			lualine_y = { "progress" },
			lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = { "nvim-tree" },
	})
end

return setup
