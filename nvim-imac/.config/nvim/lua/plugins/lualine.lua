local colors = {
    blue = "#33b1ff",
    cyan = "#3ddbd9",
    black = "#262626",
    white = "#dde1e6",
    red = "#ff5189",
    violet = "#ff7eb6",
    grey = "#393939",
}
--[[ local bubbles_theme = { ]]
--[[ 	normal = { ]]
--[[ 		a = { fg = colors.black, bg = colors.violet }, ]]
--[[ 		b = { fg = colors.white, bg = colors.grey }, ]]
--[[ 		c = { fg = colors.blue, bg = colors.black }, ]]
--[[ 		x = { fg = colors.white, bg = colors.black }, ]]
--[[ 	}, ]]
--[[ 	insert = { a = { fg = colors.black, bg = colors.blue } }, ]]
--[[ 	visual = { a = { fg = colors.black, bg = colors.cyan } }, ]]
--[[ 	replace = { a = { fg = colors.black, bg = colors.red } }, ]]
--[[ 	inactive = { ]]
--[[ 		a = { fg = colors.white, bg = colors.black }, ]]
--[[ 		b = { fg = colors.white, bg = colors.black }, ]]
--[[ 		c = { fg = colors.black, bg = colors.black }, ]]
--[[ 	}, ]]
--[[ } ]]
return {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
        "SmiteshP/nvim-navic",
    },
    config = function()
        local navic = require("nvim-navic")
        require("lualine").setup({
            globalstatus = true,
            options = {
                icons_enabled = true,
                theme = bubbles_theme,
                component_separators = "|",
                section_separators = { left = "", right = "" },
                disabled_filetypes = {},
                --[[ always_divide_middle = true, ]]
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    { "filename", path = 1 },
                    {
                        function()
                            return navic.get_location()
                        end,
                        cond = function()
                            if vim.bo.filetype == "astro" then
                                return false
                            end
                            return navic.is_available()
                        end,
                    },
                },
                lualine_x = {
                    {
                        require("noice").api.statusline.mode.get,
                        cond = require("noice").api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    { "encoding", "fileformat", "filetype" },
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
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
        })
    end,
}
