--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
    return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
            return ""
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
            return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
        end
        return str
    end
end

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "SmiteshP/nvim-navic",
    },
    config = function()
        local navic = require "nvim-navic"
        require("lualine").setup {
            --[[ globalstatus = true, ]]
            options = {
                icons_enabled = true,
                theme = "catppuccin",
                component_separators = "|",
                section_separators = { left = "", right = "" },
                disabled_filetypes = {},
                always_divide_middle = false,
            },
            sections = {
                lualine_a = {
                    { "mode", separator = { left = "", right = "" }, right_padding = 2 },
                },
                lualine_b = {
                    { "b:gitsigns_head", icon = "" },
                    { "diff", source = diff_source },
                    "diagnostics",
                },
                lualine_c = {
                    { "filename", path = 0 },
                },
                lualine_x = {
                    {
                        require("noice").api.statusline.mode.get,
                        cond = require("noice").api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    { "encoding" },
                    { "fileformat" },
                    { "filetype" },
                },
                lualine_y = { "progress" },
                lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { "nvim-tree" },
        }
    end,
}
