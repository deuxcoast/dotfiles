local conditions = require("heirline.conditions")
local util = require("deux.config.heirline.util")
local icons = util.icons
local priority = util.priority
local theme = require("deux.config.heirline.theme")
local hl = theme.highlight
local lsp_colors = theme.lsp_colors
local Space = util.Space

local LspIndicator = {
	provider = icons.circle_small .. " ",
	hl = hl.LspIndicator,
}

local LspServer = {
	Space,
	{
		provider = function(self)
			local names = self.lsp_names
			if #names == 1 then
				names = names[1]
			else
				names = table.concat(names, ", ")
			end
			return names
		end,
	},
	Space(2),
	hl = hl.LspServer,
}

local Lsp = {
	condition = conditions.lsp_attached,
	init = function(self)
		local names = {}
		for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		self.lsp_names = names
	end,
	hl = function(self)
		local color
		for _, name in ipairs(self.lsp_names) do
			if lsp_colors[name] then
				color = lsp_colors[name]
				break
			end
		end
		if color then
			return { fg = color, bold = true, force = true }
		else
			return hl.LspServer
		end
	end,
	flexible = priority.Lsp,

	LspServer,
	LspIndicator,
}

return Lsp
