return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        --[[ "rcarriga/nvim-notify", ]]
    },
    init = function()
        vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
            if not require("noice.lsp").scroll(4) then
                return "<c-f>"
            end
        end, { silent = true, expr = true })

        vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
            if not require("noice.lsp").scroll(-4) then
                return "<c-b>"
            end
        end, { silent = true, expr = true })
    end,
    opts = {
        lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                --[[ ["cmp.entry.get_documentation"] = true, ]]
            },
            documentation = {
                opts = {
                    border = {
                        padding = {
                            top = 1,
                            bottom = 1,
                            left = 1,
                            right = 1,
                        },
                        { style = "rounded" },
                    },
                    relative = "win",
                    position = {
                        row = 2,
                    },
                    position = {
                        row = "0%",
                        col = "100%",
                    },
                    size = {
                        width = 80,
                    },
                    win_options = {
                        concealcursor = "n",
                        --[[ conceallevel = 3, ]]
                        winhighlight = {
                            Normal = "NormalFloat",
                            FloatBorder = "FloatBorder",
                        },
                    },
                },
            },
        },
        cmdline = {
            view = "cmdline",
            format = {
                search_down = {
                    view = "cmdline",
                },
                search_up = {
                    view = "cmdline",
                },
            },
        },
        presets = {
            -- you can enable a preset by setting it to true, or a table that will override the preset config
            -- you can also add custom presets that you can enable/disable with enabled=true
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        --[[ popupmenu = { ]]
        --[[ 	enabled = true, -- enables the Noice popupmenu UI ]]
        --[[ 	---@type 'nui'|'cmp' ]]
        --[[ 	backend = "nui", -- backend to use to show regular cmdline completions ]]
        --[[ 	---@type NoicePopupmenuItemKind|false ]]
        --[[ 	-- Icons for completion item kinds (see defaults at noice.config.icons.kinds) ]]
        --[[ 	kind_icons = {}, -- set to `false` to disable icons ]]
        --[[ }, ]]
        --[[ }, ]]
    },
}
