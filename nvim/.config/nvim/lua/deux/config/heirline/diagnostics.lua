local conditions = require("heirline.conditions")
local diagnostic_icons = require("deux.icons").diagnostic
local hl = require("deux.config.heirline.theme").highlight

local Space = require("deux.config.heirline.util").Space

local Diagnostics = {
	condition = conditions.has_diagnostics,
	static = {
		error_icon = diagnostic_icons.Error.text,
		warn_icon = diagnostic_icons.Warn.text,
		info_icon = diagnostic_icons.Info.text,
		hint_icon = diagnostic_icons.Hint.text,
	},
	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,
	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. " " .. self.errors .. " ")
		end,
		hl = hl.Diagnostic.error,
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ")
		end,
		hl = hl.Diagnostic.warn,
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. " " .. self.info .. " ")
		end,
		hl = hl.Diagnostic.info,
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. " " .. self.hints)
		end,
		hl = hl.Diagnostic.hint,
	},
	Space(2),
}

return Diagnostics
