return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			highlights = {
				Normal = { link = "Normal" },
				NormalFloat = { link = "Normal" }, -- also using NormalFloat here makes the border weird
				-- FloatBorder = { link = "FloatBorder" },
				-- SignColumn = { link = "SignColumn" },
				StatusLine = { link = "StatusLine" },
				StatusLineNC = { link = "StatusLineNC" },
			},
			-- size can be a number or function which is passed the current terminal
			size = function(term)
				if term.direction == "horizontal" then
					return 21
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = "<C-t>",
			terminal_mappings = true,
			-- -- on_open = fun(t: Terminal), -- function to run when the terminal opens
			-- -- on_close = fun(t: Terminal), -- function to run when the terminal closes
			hide_numbers = true, -- hide the number column in toggleterm buffers
			-- shade_filetypes = {},
			shade_terminals = false,
			shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
			start_in_insert = true,
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			persist_size = true,
			direction = "horizontal", -- | 'vertical' | 'tab' | 'float',
			close_on_exit = true, -- close the terminal window when the process exits
			shell = vim.o.shell, -- change the default shell
			-- -- This field is only relevant if direction is set to 'float'
			float_opts = {
				--   -- The border key is *almost* the same as 'nvim_open_win'
				--   -- see :h nvim_open_win for details on borders however
				--   -- the 'curved' border is a custom border type
				--   -- not natively supported but implemented in this plugin.
				border = "curved", --'single' | 'double' | 'shadow' | 'curved',
				--   width = number,
				--   height = number,
				winblend = 0,
				-- highlights = {
				-- 	border = "Normal",
				-- 	background = "Normal",
				-- },
			},
		})

		-- vim.keymap.set("n", "<a-\\>", ":ToggleTerm direction=vertical<CR>")
		-- Open a floating terminal
		vim.keymap.set("n", "<C-o>", ":ToggleTerm direction=float<CR>")
		-- Toggle terminal, but keep it active in background
		vim.keymap.set("t", "<C-o>", "<CMD>ToggleTerm<CR>")

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			direction = "float",
			float_opts = {
				border = "curved",
			},
			hidden = true,
		})

		function _lazygit_toggle()
			lazygit:toggle()
		end

		vim.api.nvim_set_keymap(
			"n",
			"<leader>gg",
			"<cmd>lua _lazygit_toggle()<CR>",
			{ noremap = true, silent = true, desc = "Lazygit in floating term" }
		)
	end,
}
