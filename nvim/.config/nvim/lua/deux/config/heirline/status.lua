if not pcall(require, "heirline") then
	return
end

local os_sep = package.config:sub(1, 1)
local api, fn = vim.api, vim.fn

local util = require("deux.config.heirline.util")
local theme = require("deux.config.heirline.theme")
local hl = theme.highlight
local LeftCap, Space, Align = util.LeftCap, util.Space, util.Align
local ModeIndicator = require("deux.config.heirline.mode")
local FileNameBlock = require("deux.config.heirline.file_name_block")
local FileProperties = require("deux.config.heirline.file_properties")
local DapMessages = require("deux.config.heirline.dap_messags")
local Diagnostics = require("deux.config.heirline.diagnostics")
local Lsp = require("deux.config.heirline.lsp")
local Git = require("deux.config.heirline.git")
local Ruler = require("deux.config.heirline.Ruler")
local SearchResults = require("deux.config.heirline.search_results")
local ScrollPercentage = require("deux.config.heirline.scroll_percentage")

local M = {}

local StatusLines = {
	init = function(self)
		local pwd = fn.getcwd(0) -- Present working directory.
		local current_path = api.nvim_buf_get_name(0)
		local filename

		if current_path == "" then
			pwd = fn.fnamemodify(pwd, ":~")
			---@diagnostic disable-next-line: cast-local-type
			current_path = nil
			filename = " [No Name]"
		elseif current_path:find(pwd, 1, true) then
			filename = fn.fnamemodify(current_path, ":t")
			current_path = fn.fnamemodify(current_path, ":~:.:h")
			pwd = fn.fnamemodify(pwd, ":~") .. os_sep
			if current_path == "." then
				---@diagnostic disable-next-line: cast-local-type
				current_path = nil
			else
				current_path = current_path .. os_sep
			end
		else
			---@diagnostic disable-next-line: cast-local-type
			pwd = nil
			filename = fn.fnamemodify(current_path, ":t")
			current_path = fn.fnamemodify(current_path, ":~:.:h") .. os_sep
		end

		self.pwd = pwd
		self.current_path = current_path -- The opened file path relevant to pwd.
		self.filename = filename
	end,
	hl = hl.StatusLine,
	{
		LeftCap,
		ModeIndicator,
		Space,
		{
			fallthrough = false,
			{ SearchResults, FileNameBlock },
		},
		Space(4),
		-- GPS,
		Align,
		DapMessages,
		Diagnostics,
		Git,
		Lsp,
		FileProperties,
		Ruler,
		ScrollPercentage,
	},
}

M.StatusLines = StatusLines

return M
