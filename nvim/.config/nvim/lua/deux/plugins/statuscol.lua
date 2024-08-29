return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			-- configuration goes here, for example:
			relculright = true,
			-- segments = {
			--   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
			--   {
			segments = {

				{
					sign = { namespace = { "gitsign" }, colwidth = 1, wrap = true, auto = false },
					click = "v:lua.ScSa",
				},
				{ sign = { namespace = { "diagnostic/signs" }, colwidth = 1, maxwidth = 1, auto = false } },
				{
					text = { builtin.lnumfunc, " " },
					condition = { true, builtin.not_empty },
					click = "v:lua.ScLa",
				},
				{ sign = { name = { "Dap*" }, auto = true } },
			},
			--     click = "v:lua.ScSa"
			--   },
			-- { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
			--   {
			--     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
			--     click = "v:lua.ScSa"
			--   },
			-- }
		})
	end,
}
