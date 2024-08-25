local conditions = require("heirline.conditions")
local hl = require("deux.config.heirline.theme").highlight

local ScrollPercentage = {
	condition = function()
		return conditions.width_percent_below(4, 0.035)
	end,
	-- %P  : percentage through file of displayed window
	provider = " %3(%P%) ",
	hl = hl.StatusLine,
}

return ScrollPercentage
