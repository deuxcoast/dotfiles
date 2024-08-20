---@class util
---@field pack util.pack
local M = {}

setmetatable(M, {
	__index = function(t, k)
		---@diagnostic disable-next-line: no-unknown
		t[k] = require("util." .. k)
		return t[k]
	end,
})

function M.map()
	local map = require("util.keymap")
	return map
end

return M
