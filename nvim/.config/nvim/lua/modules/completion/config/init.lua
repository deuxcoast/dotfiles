local M = {}
local config = "modules.completion.config."

M.completion = require(config .. "cmp")
M.luasnip = require(config .. "luasnip")

return M
