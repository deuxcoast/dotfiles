local package = DV.pack.package

package({
	{ "mfussenegger/nvim-dap", event = "VeryLazy" },
	{ "rcarriga/nvim-dap-ui", event = "VeryLazy" },
	{ "theHamsta/nvim-dap-virtual-text", event = "VeryLazy" },
	{ "nvim-telescope/telescope-dap.nvim", event = "VeryLazy" },
	--  Adapter configuration for specific languages
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
	},
	{ "mfussenegger/nvim-dap-python" },
	{ "jbyuki/one-small-step-for-vimkind" },
	{ "mxsdev/nvim-dap-vscode-js" },
})
