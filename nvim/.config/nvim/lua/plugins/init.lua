return {
	{ dir = "~/duexcoast/plugins/stackmap.nvim" },
	{ "kana/vim-textobj-entire", dependencies = { "kana/vim-textobj-user" } }, -- select entire buffer
	{ "kana/vim-textobj-line", dependencies = { "kana/vim-textobj-user" } }, -- select entire line
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"kazhala/close-buffers.nvim",
		config = function()
			vim.keymap.set("n", "<leader>q", function()
				require("close_buffers").delete({ type = "this" }) -- Delete the current buffer
			end)
		end,
	},
	{ "nvim-lua/plenary.nvim" }, -- useful lua functions
	{ "nvim-lua/popup.nvim" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-rhubarb" },
	{ "tpope/vim-unimpaired" },
	{ "mg979/vim-visual-multi" },
	{ "lambdalisue/suda.vim" },
	{ "sindrets/diffview.nvim", opts = { file_panel = { win_config = { position = "left" } } } },
	{ "jbyuki/one-small-step-for-vimkind" }, -- debug adapter for nvim lua
	{
		"rhysd/accelerated-jk",
		lazy = true,
		event = "BufEnter",
	},
	{
		"max397574/better-escape.nvim",
		lazy = true,
		event = "BufEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"hrsh7th/vim-eft",
		lazy = true,
		event = "BufEnter",
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	},
	{
		"szw/vim-maximizer",
		lazy = true,
		event = "BufEnter",
		init = function()
			vim.keymap.set("n", "<leader>mm", ":MaximizerToggle!<CR>")
		end,
	},
	-- FINALLY: configures lua_ls to behave appropriately with my nvim config
	-- codebase. Folke died for my sins so I didn't have to.
	{ "folke/neodev.nvim", opts = {} },
	{ "mfussenegger/nvim-treehopper" },
	-- {
	-- 	"natecraddock/workspaces.nvim",
	-- 	lazy = true,
	-- 	opts = { hooks = { open = { "NvimTreeOpen", "Telescope find_files" } } },
	-- },
	{
		"gabrielpoca/replacer.nvim",
		init = function()
			vim.api.nvim_set_keymap("n", "<Leader>gr", ':lua require("replacer").run()<cr>', { silent = true })
		end,
	},
	{
		"mbbill/undotree",
		lazy = true,
		event = "BufEnter",
	},
	{
		"mfussenegger/nvim-treehopper",
		lazy = true,
		event = "InsertEnter",
	},
	{ "nvim-tree/nvim-web-devicons" },
	-- { "lukas-reineke/indent-blankline.nvim" }, -- indentation guides
	{ "RishabhRD/nvim-cheat.sh", dependencies = "RishabhRD/popfix" },
	{ "weilbith/nvim-code-action-menu" },
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	{ "nvim-lua/lsp-status.nvim" }, -- generate statusline components from the LSP client.
	{ "jose-elias-alvarez/typescript.nvim" },
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "ThePrimeagen/refactoring.nvim", config = true },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},
	{
		"simrat39/symbols-outline.nvim",
		opts = { highlight_hovered_item = true },
		init = function()
			vim.keymap.set("n", "<leader>xo", "<cmd>SymbolsOutline<CR>")
		end,
	},
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", config = true },
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
	{ "theHamsta/nvim-dap-virtual-text", config = true },
	{ "leoluz/nvim-dap-go" },
	{ "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
	{ "preservim/vim-markdown", lazy = true },
	{ "mattn/emmet-vim", lazy = true, event = "BufEnter" },
	{ "b0o/SchemaStore.nvim", lazy = true },
	{ "fedepujol/move.nvim", lazy = true, event = "BufEnter" },
	{ "vim-scripts/ReplaceWithRegister", lazy = true, event = "BufEnter" },
	{ "christoomey/vim-tmux-navigator", lazy = true, event = "BufEnter" },
}
