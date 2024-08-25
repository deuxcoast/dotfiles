local bo, fn, api = vim.bo, vim.fn, vim.api
local util = require("deux.config.heirline.util")
local hl = require("deux.config.heirline.theme").highlight
local Space, Align = util.Space, util.Align
local ModeIndicator = require("deux.config.heirline.ModeIndicator")
local ScrollPercentage = require("deux.config.ScrollPercentage")

local HelpBufferStatusline = {
	condition = function()
		return bo.filetype == "help"
	end,
	Space,
	ModeIndicator,
	{
		provider = function()
			local filename = api.nvim_buf_get_name(0)
			return fn.fnamemodify(filename, ":t")
		end,
		hl = hl.FileName,
	},
	Align,
	ScrollPercentage,
}

return HelpBufferStatusline
