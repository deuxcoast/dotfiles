local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}):wait()
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("deux.plugins", {
	change_detection = {
		enabled = false,
	},
	checker = {
		-- needed to get the output of require("lazy.status").updates()
		enabled = true,
		-- get a notification when new updates are found?
		notify = false,
	},
	dev = {
		fallback = true,
		path = "~/deuxcoast/nvim-plugins-local",
	},
	rocks = { enabled = false, hererocks = false },
	ui = { border = require("deux.settings").get("border") },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen", -- vim-matchup will re-load this anyway
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

vim.cmd.colorscheme("oh-lucy-evening")
