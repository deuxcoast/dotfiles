local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

local map = require("deux.utils.keymap")
local cmd = map.cmd

return {

	-- =========================================================================
	-- ui: components
	-- =========================================================================

	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		cond = has_ui,
		config = true,
	},

	-- =========================================================================
	-- ui: buffer and window manipulation
	-- =========================================================================

	{
		"alexghergh/nvim-tmux-navigation",
		cond = has_ui,
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = true, -- defaults to false
				keybindings = {
					left = "<C-h>",
					down = "<C-j>",
					up = "<C-k>",
					right = "<C-l>",
					last_active = "<C-\\>",
					next = "<C-Space>",
				},
			})
		end,
	},
	-- {
	--   "yorickpeterse/nvim-window",
	--   cond = has_ui,
	--   keys = {
	--     { "<leader>wj", "<cmd>lua require('nvim-window').pick()<cr>", desc = "nvim-window: Jump to window" },
	--   },
	--   config = true,
	-- },

	-- =========================================================================
	-- text editing tools
	-- =========================================================================

	--------------------------------------------------------------------------------
	-- Nvim-Autopairs
	-- Intelligently provides closing parens, brackets, etc.
	--------------------------------------------------------------------------------
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function() require("nvim-autopairs").setup() end,
	},

	--------------------------------------------------------------------------------
	-- Nvim-Colorizer
	-- Provides highlights for hex colors in text
	--------------------------------------------------------------------------------
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufEnter",
		config = function()
			vim.opt.termguicolors = true
			require("colorizer").setup()
		end,
	},

	--------------------------------------------------------------------------------
	-- Gx.nvim
	-- Gx will open plugins, docs, links, etc in browser
	--------------------------------------------------------------------------------
	{
		"chrishrb/gx.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true, -- default settings
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		dev = true,
	},

	--------------------------------------------------------------------------------
	-- Nvim-Surround
	-- Functions and keymaps for dealing with surrounding characters
	--------------------------------------------------------------------------------
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- vim-sandwich keymaps
				keymaps = {
					-- add surrounding character
					normal = "sa",
					-- remove surrounding character
					delete = "sd",
					-- change surrounding character
					change = "sr",
				},
			})
		end,
	},

	--------------------------------------------------------------------------------
	-- Nvim-Ts-Autotag
	-- Use treesitter to auto close and auto rename html tag
	--------------------------------------------------------------------------------
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},

	--------------------------------------------------------------------------------
	-- Rainbow-Delimiters
	-- Rainbow parentheses using treesitter
	--------------------------------------------------------------------------------
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufEnter",
		config = function()
			require("rainbow-delimiters.setup").setup({
				highlight = {
					-- change the order in which the rainbow delimiters highlight groups
					-- are utilized
					-- 'RainbowDelimiterRed',
					-- 'RainbowDelimiterYellow',
					-- 'RainbowDelimiterBlue',
					-- 'RainbowDelimiterOrange',
					-- 'RainbowDelimiterGreen',
					-- 'RainbowDelimiterViolet',
					-- 'RainbowDelimiterCyan',
				}
			})
		end
	},

	--------------------------------------------------------------------------------
	-- Better-Escape
	-- Provides `jk` keymap for leaving insert mode without delaying input of `j`
	--------------------------------------------------------------------------------
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup({
				mappings = {
					v = {
						j = {
							k = false,
						},
					},
				}
			})
		end,
	},

	--------------------------------------------------------------------------------
	-- Hop
	-- Provides motions for hopping around the buffer
	--------------------------------------------------------------------------------
	{
		"phaazon/hop.nvim",
		opts = { jump_on_sole_occurrence = true },
		init = function()
			map.n({
				["<leader>o"] = cmd("HopWord"),
				["<leader>j"] = cmd("HopLineStartAC"),
				["<leader>k"] = cmd("HopLineStartBC"),
			})
		end,
	},

	--------------------------------------------------------------------------------
	-- Move
	-- Move lines and blocks of text, with ato indentation
	--------------------------------------------------------------------------------
	{
		"fedepujol/move.nvim",
		config = function()
			require("move").setup({})
			map.n({
				["<M-k>"] = cmd("MoveLine (-1)"),
				["<M-j>"] = cmd("MoveLine (1)"),
			})
			map.v({
				["<M-j>"] = ":MoveBlock(1)<CR>",
				["<M-k>"] = ":MoveBlock(-1)<CR>",
			})
		end,
	},

	--------------------------------------------------------------------------------
	-- Vim-eft
	-- Better f/t/F/T mappings that provide highlights
	--------------------------------------------------------------------------------
	{
		"hrsh7th/vim-eft",
		event = "BufEnter",
		config = function()
			map.nxo({
				[";"] = "<Plug>(eft-repeat)",
				["f"] = "<Plug>(eft-f)",
				["F"] = "<Plug>(eft-F)",
				["t"] = "<Plug>(eft-t)",
				["T"] = "<Plug>(eft-T)",
			})
		end
	},

	--------------------------------------------------------------------------------
	-- Nvim-Treehopper
	-- Region selection in visual mode, using TS nodes and movements from `hop.nvim`
	--------------------------------------------------------------------------------
	{
		"mfussenegger/nvim-treehopper",
		event = "InsertEnter",
		config = function()
			map.o("m", ":<C-U> lua require('tsht').nodes()<CR>", { remap = true })
			map.x("m", ":lua require('tsht').nodes()<CR>")
		end
	},

	--------------------------------------------------------------------------------
	-- Todo-Comments
	-- -
	--------------------------------------------------------------------------------
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	},

	{ "tpope/vim-unimpaired" },

	{
		"SmiteshP/nvim-navic",
		config = function()
			require("nvim-navic").setup({
				lsp = {
					auto_attach = true,
				}
			})
		end
	},

}
