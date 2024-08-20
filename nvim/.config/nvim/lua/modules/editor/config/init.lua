local config = {}
local module = "modules.editor.config."

config.treesitter = require(module .. "treesitter")
config.telescope = require(module .. "telescope")
config.oil = require(module .. "oil")
config.gitsigns = require(module .. "gitsigns")
config.toggleterm = require(module .. "toggleterm")

return config
