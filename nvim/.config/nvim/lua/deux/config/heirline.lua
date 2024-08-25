local M = {}

M.setup = function()
	local utils = require("heirline.utils")
	local theme = require("deux.config.heirline.theme")
	local function setup_colors()
		return theme.highlight
	end

	require("heirline").load_colors(theme.highlight)

	vim.api.nvim_create_augroup("Heirline", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = function()
			utils.on_colorscheme(setup_colors)
		end,
		group = "Heirline",
	})

	local GLOBAL = 3
	vim.o.laststatus = GLOBAL

	require("heirline").setup({
		statusline = require("deux.config.heirline.status").StatusLines,
	})
end

M.setup()

return M
