local setup = function()
	local trouble = require("trouble")
	trouble.setup({})

	local map = DV.map()
	local cmd = map.cmd

	map.n({
		["<leader>lw"] = cmd("Trouble diagnostics toggle"),
		["<leader>ld"] = cmd("Trouble diagnostics toggle filter.buf=0"),
		["<leader>lr"] = cmd("Trouble lsp toggle focus=false win.position=right"),
		["<leader>ll"] = cmd("Trouble loclist toggle"),
		["<leader>lq"] = cmd("Trouble qflist toggle"),
	})
end

return setup
