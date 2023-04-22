------------------------------------------------------
-- QuickScope
-- vim.cmd([[hi QuickScopePrimary guifg=#29CB2B gui=underline ctermfg=155 cterm=underline]])
-- vim.cmd([[hi QuickScopeSecondary guifg=#74CFD3 gui=underline ctermfg=81 cterm=underline]])

local colorscheme = "moonfly"
vim.opt.background = "dark"
vim.g.moonflyItalics = false
vim.g.moonflyNormalFloat = true
vim.g.moonflyWinSeparator = 0
vim.g.moonflyVirtualTextColor = true
vim.g.moonflyUnderlineMatchParen = true
vim.g.moonflyCursorColor = true

require("config.theme.theme").setup(colorscheme)
require("config.theme.highlights")

local util = require("config.theme.util")

--[[ require("config.theme.cmp").setupColors() ]]
--[[ require("config.theme.kitty-background") ]]
