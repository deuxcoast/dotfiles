local M = {}

local sev_to_icon = {}
local signs = { linehl = {}, numhl = {}, text = {} }

local diagnostic_signs = require("deux.icons").diagnostic
for k, v in pairs(diagnostic_signs) do
	local hl = v.name
	local icon = v.text

	local code = vim.diagnostic.severity[k]

	-- for vim.notify icon
	sev_to_icon[code] = icon

	-- vim.diagnostic.config signs
	signs.text[code] = ("%s "):format(icon)
	signs.numhl[code] = hl

	-- Only colorize entire line for errors
	if code == vim.diagnostic.severity.ERROR then
		signs.linehl[code] = hl
	end
end

-- ===========================================================================
-- Diagnostic configuration
-- ===========================================================================

local function float_format(diagnostic)
	local symbol = sev_to_icon[diagnostic.severity] or "-"
	local source = diagnostic.source
	if source then
		if source.sub(source, -1, -1) == "." then
			-- strip period at end
			source = source:sub(1, -2)
		end
	else
		source = "NIL.SOURCE"
		vim.print(diagnostic)
	end
	-- local source_tag = require("deux.utils.string").smallcaps(("%s"):format(source))
	local code = diagnostic.code and ("[%s]"):format(diagnostic.code) or ""
	return ("%s %s\n%s\n\n%s"):format(symbol, source, code, diagnostic.message)
end

vim.diagnostic.config({
	signs = signs,
	-- virtual_lines = { only_current_line = true }, -- for lsp_lines.nvim
	underline = false,
	virtual_text = true,
	float = {
		border = require("deux.settings").get("border"),
		-- header = "Diagnostic:\n", -- remove the line that says 'Diagnostic:'
		source = false, -- hide it since my float_format will add it
		format = float_format, -- can customize more colors by using prefix/suffix instead
		suffix = "\n", -- default is error code. Moved to message via float_format
	},
	update_in_insert = false, -- wait until insert leave to check diagnostics
})

return M
