local M = {}

local config = "modules.ui.config."

M.alpha = require(config .. "alpha")
M.heirline = require(config .. "heirline")

return M
