return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	init = function()
		vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
			if not require("noice.lsp").scroll(4) then
				return "<c-f>"
			end
		end, { silent = true, expr = true })

		vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
			if not require("noice.lsp").scroll(-4) then
				return "<c-b>"
			end
		end, { silent = true, expr = true })
	end,

	opts = {
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				--[[ ["cmp.entry.get_documentation"] = true, ]]
			},
			documentation = {
				opts = {
					border = {
						padding = {
							top = 1,
							bottom = 1,
							left = 1,
							right = 1,
						},
						{ style = "rounded" },
					},
					size = {
						max_width = 80,
						max_height = 20,
					},
				},
			},
		},
		cmdline = {
			view = "cmdline",
			format = {
				search_down = {
					view = "cmdline",
				},
				search_up = {
					view = "cmdline",
				},
			},
		},
		-- views = {
		-- 	split = {
		-- 		enter = true,
		-- 		position = "bottom",
		-- 		size = "20%",
		-- 		close = {
		-- 			keys = { "<C-c>" },
		-- 		},
		-- 	},
		-- },
		routes = {
			{
				-- don't show messages when buffer is written
				filter = {
					event = "msg_show",
					kind = "",
					find = "written",
				},
				opts = { skip = true },
			},
			{
				-- don't show error message when writing to a buffer with no changes
				-- E162: No write since last change for buffer "[No Name]"
				filter = {
					event = "msg_show",
					kind = "emsg",
					find = "E162",
				},
				opts = { skip = true },
			},
			{
				-- don't show error messages when writing to a buffer with no changes
				-- E37: No write since last change
				filter = {
					event = "msg_show",
					kind = "emsg",
					find = "E37",
				},
				opts = { skip = true },
			},
		},
		presets = {
			-- you can enable a preset by setting it to true, or a table that will override the preset config
			-- you can also add custom presets that you can enable/disable with enabled=true
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			lsp_doc_border = true, -- add a border to hover docs and signature help
			cmdline_output_to_split = true, -- this is nice when I want to have a full split to browse on, but also it makes a split for just :w
		},
		--[[ popupmenu = { ]]
		--[[ 	enabled = true, -- enables the Noice popupmenu UI ]]
		--[[ 	---@type 'nui'|'cmp' ]]
		--[[ 	backend = "nui", -- backend to use to show regular cmdline completions ]]
		--[[ 	---@type NoicePopupmenuItemKind|false ]]
		--[[ 	-- Icons for completion item kinds (see defaults at noice.config.icons.kinds) ]]
		--[[ 	kind_icons = {}, -- set to `false` to disable icons ]]
		--[[ }, ]]
	},
}
