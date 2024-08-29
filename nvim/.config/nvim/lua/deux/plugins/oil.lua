local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

local map = require("deux.utils.keymap")
local cmd = map.cmd

return {
	{
		"stevearc/oil.nvim",
		cond = has_ui,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local oil = require("oil")
			oil.setup({
				default_file_explorer = true,
				delete_to_trash = true,
				skip_confirm_for_simple_edits = true,
				win_options = {
					signcolumn = "yes:2",
				},
				columns = { "icon" },
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-k>"] = false,
					["<C-j>"] = false,
					["<M-h>"] = "actions.select_split",
				},
				view_options = {
					show_hidden = true,
					natural_order = true,
					is_always_hidden = function(name, _)
						return name == ".." or name == ".git"
					end,
				},
				win_options = {
					wrap = true,
				},
			})

			map.n({
				["-"] = cmd("Oil"),
				["<leader>-"] = cmd("lua require('oil').toggle_float()<CR>"),
			})
		end,
	},
	-- {
	-- 	"refractalize/oil-git-status.nvim",
	--
	-- 	dependencies = {
	-- 		"stevearc/oil.nvim",
	-- 	},
	--
	-- 	config = true,
	-- },
}
