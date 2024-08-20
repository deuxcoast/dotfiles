local M = {}

local config = "modules.ui.config."

M.alpha = require(config .. "alpha")
M.lualine = require(config .. "lualine")

return M
