local M = {}

local sev_to_icon = {}
local signs = { linehl = {}, numhl = {}, text = {} }

local diagnostic_signs = require("deux.icons").diagnostic
for k, v in pairs(diagnostic_signs) do
	local hl = v.name
	local icon = v.text

	local key = k:upper()
	local code = vim.diagnostic.severity[key]

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

-- how should diagnostics show up?
local function float_format(diagnostic)
	--[[ e.g.
  {
    bufnr = 1,
    code = "trailing-space",
    col = 4,
    end_col = 5,
    end_lnum = 44,
    lnum = 44,
    message = "Line with postspace.",
    namespace = 12,
    severity = 4,
    source = "Lua Diagnostics.",
    user_data = {
      lsp = {
        code = "trailing-space"
      }
    }
  }
  ]]

	-- diagnostic.message may be pre-parsed in lspconfig's handlers
	-- ["textDocument/publishDiagnostics"]
	-- e.g. tsserver in deux/plugins/lsp.lua

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
	local source_tag = require("deux.utils.string").smallcaps(("%s"):format(source))
	local code = diagnostic.code and ("[%s]"):format(diagnostic.code) or ""
	return ("%s %s %s\n%s"):format(symbol, source_tag, code, diagnostic.message)
end

vim.diagnostic.config({
	signs = signs,
	-- virtual_lines = { only_current_line = true }, -- for lsp_lines.nvim
	underline = false,
	virtual_text = false,
	float = {
		border = require("deux.settings").get("border"),
		header = "", -- remove the line that says 'Diagnostic:'
		source = false, -- hide it since my float_format will add it
		format = float_format, -- can customize more colors by using prefix/suffix instead
		suffix = "", -- default is error code. Moved to message via float_format
	},
	update_in_insert = false, -- wait until insert leave to check diagnostics
})

return M
