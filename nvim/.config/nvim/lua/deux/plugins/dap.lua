return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			"leoluz/nvim-dap-go",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap-python",
			"jbyuki/one-small-step-for-vimkind",
			"mxsdev/nvim-dap-vscode-js",

		},
		config = function()
			require("deux.config.dap").setup()
		end,
	},
}
