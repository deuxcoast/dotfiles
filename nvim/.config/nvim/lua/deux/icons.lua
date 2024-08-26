--  ✕ ✖ ✘ ‼   ❢ ❦ ‽    ⁕ ⚑ ✔  ✎
local M = {}

M.diagnostic = {
	ERROR = { name = "DiagnosticSignError", text = "" },
	WARN = { name = "DiagnosticSignWarn", text = "" },
	INFO = { name = "DiagnosticSignInfo", text = "" },
	HINT = { name = "DiagnosticSignHint", text = "" },
}

M.debug = {
	DapStopped = { text = "", name = "DapStopped" },
	DapBreakpoint = { text = "", name = "DapBreakpoint" },
	DapBreakpointCondition = { text = "", name = "DapBreakpointCondition" },
	DapLogPoint = { text = "◆", name = "DapLogPoint" },
}

M.misc = {
	vertical_bar = "│",
	git = "",
	ellipsis = "…",
}

M.symbol_kinds = {
	--- LSP symbol kinds.
	Array = "󰅪",
	Class = "",
	Color = "󰏘",
	Constant = "󰏿",
	Constructor = "",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "󰜢",
	File = "󰈙",
	Folder = "󰉋",
	Function = "󰆧",
	Interface = "",
	Keyword = "󰌋",
	Method = "󰆧",
	Module = "",
	Operator = "󰆕",
	Property = "󰜢",
	Reference = "󰈇",
	Snippet = "",
	Struct = "",
	Text = "",
	TypeParameter = "",
	Unit = "",
	Value = "",
	Variable = "󰀫",
}

return M
