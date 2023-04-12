-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    bg = "NONE",
    italic = false,
  },
  NvimTreeNormal = {bg = "darker_black", fg = "darker_black"},
  NvimTreeFolderIcon = {bg = "darker_black", fg = "green"},
  NvimTreeFolderName = {fg = "green"},
  NvimTreeOpenedFolderName = { fg = "lavender",  },
  DiffAdd = {  fg = "green" },
  DiffChange = {  fg = "purple" },
  DiffChangeDelete = { fg = "red"},
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "white", bold = true, italic = true },
  ColorColumn = {bg = "#0a0a0a"},
  GitSignsAddLnInLine = {bg = "green", fg = "green"},
}

M.changed_themes = {
  oxocarbon = {
    base_30 = {
      darker_black = "#000000",
    },
    base_16 = {
      base00 = "#000000",
    },
  },
}

return M
