local util = require("config.theme.util")
local colors = {
	base00 = "#161616",
	base01 = "#262626",
	base02 = "#393939",
	base03 = "#525252",
	base04 = "#dde1e6",
	base05 = "#f2f4f8",
	base06 = "#ffffff",
	base07 = "#08bdba",
	base08 = "#3ddbd9",
	base09 = "#78a9ff",
	base10 = "#ffe97b",
	base0A = "#ee5396",
	base0B = "#33b1ff",
	base0C = "#ff7eb6",
	base0D = "#42be65",
	base0E = "#be95ff",
	base0F = "#82cfff",
}

util.highlight("FloatBorder", { fg = colors.base05 })
util.highlight("ColorColumn", { fg = "#000000" })

-- GitSigns
util.highlight("DiffAdd", { fg = colors.base0D })
util.highlight("DiffChange", { fg = colors.base0E })
util.highlight("DiffChangeDelete", { fg = colors.base10 })
util.highlight("DiffDelete", { fg = colors.base0A })
util.highlight("GitSignsAdd", { fg = colors.base0B })

-- Diagnostics
util.highlight("DiagnosticSignWarn", { fg = colors.base10 })
util.highlight("DiagnosticSignError", { fg = colors.base0A })
