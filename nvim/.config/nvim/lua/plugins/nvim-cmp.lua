return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "saadparwaiz1/cmp_luasnip",
        -- "mireq/luasnip-snippets",
        "onsails/lspkind.nvim",
        "abecodes/tabout.nvim",
    },
    config = function()
        local presentCmp, cmp = pcall(require, "cmp")
        local lspkind = require "lspkind"

        -- Add additional capabilities supported by nvim-cmp
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local lspconfig = require "lspconfig"

        -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
        -- local servers = { "clangd", "pyright", "tsserver" }
        local servers = { "pyright", "tsserver" }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                -- on_attach = my_custom_on_attach,
                capabilities = capabilities,
            }
        end

        local winhighlight = {
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
        }

        vim.cmd "highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#BAC2DE"
        vim.cmd "highlight! CmpItemAbbrMatch guibg=NONE guifg=#89B4FA"
        vim.cmd "highlight! CmpItemKindField guibg=NONE guifg=#F38BA8"
        vim.cmd "highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#89B4FA"
        vim.cmd "highlight! CmpItemKindProperty guibg=NONE guifg=#F38BA8"
        vim.cmd "highlight! CmpItemKindConstant guibg=NONE guifg=#F38BA8"
        vim.cmd "highlight! CmpItemKindVariable guibg=NONE guifg=#B4BEFE"
        vim.cmd "highlight! CmpItemKindInterface guibg=NONE guifg=#B4BEFE"
        vim.cmd "highlight! CmpItemKindText guibg=NONE guifg=#94E2D5"
        vim.cmd "highlight! CmpItemKindFunction guibg=NONE guifg=#F5C2E7"
        vim.cmd "highlight! CmpItemKindMethod guibg=NONE guifg=#F5C2E7"
        vim.cmd "highlight! CmpItemKindStruct guibg=NONE guifg=#F9E2AF"
        vim.cmd "highlight! CmpItemKindClass guibg=NONE guifg=#F9E2AF"
        vim.cmd "highlight! CmpItemKindModule guibg=NONE guifg=#A6E3A1"
        vim.cmd "highlight! CmpItemKindSnippet guibg=NONE guifg=#A6E3A1"
        vim.cmd "highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4"
        vim.cmd "highlight! CmpItemKindFile guibg=NONE guifg=#FAB387"
        require "cmp.types"

        local types = require "cmp.types"
        local str = require "cmp.utils.str"

        local icons = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
        }

        -- if not presentCmp or not present_lua_snip then
        --     return
        -- end

        ---@diagnostic disable-next-line: missing-fields
        cmp.setup {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = "menu,menuone,noselect",
            },
            enabled = function()
                local buftype = vim.api.nvim_buf_get_option(0, "buftype")
                if buftype == "prompt" then
                    return false
                end
                -- disable completion in comments
                local context = require "cmp.config.context"
                -- keep command mode completion enabled when cursor is in a comment
                if vim.api.nvim_get_mode().mode == "c" then
                    return true
                else
                    return not context.in_treesitter_capture "comment" and not context.in_syntax_group "Comment"
                end
            end,
            mapping = {
                ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping(
                    cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },
                    { "i", "c" }
                ),
                ["<M-y>"] = cmp.mapping(
                    cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    },
                    { "i", "c" }
                ),
                ["<c-space>"] = cmp.mapping {
                    i = cmp.mapping.complete(),
                    c = function(
                        _ --[[fallback]]
                    )
                        if cmp.visible() then
                            if not cmp.confirm { select = true } then
                                return
                            end
                        else
                            cmp.complete()
                        end
                    end,
                },
                ["<tab>"] = cmp.config.disable,

                -- Maybe?
                ["<c-q>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                },
            },
            window = {
                completion = cmp.config.window.bordered(winhighlight),
                documentation = cmp.config.window.bordered(winhighlight),
            },

            ---@diagnostic disable-next-line: missing-fields
            formatting = {
                format = lspkind.cmp_format {
                    mode = "symbol_text",
                    maxwidth = 60,
                    maxheight = 150,
                    before = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "󰊷",
                            nvim_lua = "",
                            treesitter = "",
                            path = "󰨣",
                            buffer = "",
                            ["vim-dadbod-completion"] = "",
                            zsh = "",
                            luasnip = "",
                            npm = "",
                        })[entry.source.name]

                        -- Get the full snippet (and only keep first line)
                        local word = entry:get_insert_text()
                        -- if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
                        --     word = vim.lsp.util.parse_snippet(word)
                        -- end
                        word = str.oneline(word)
                        if
                            entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
                            and string.sub(vim_item.abbr, -1, -1) == "~"
                        then
                            word = word .. "~"
                        end
                        vim_item.abbr = word

                        return vim_item
                    end,
                },
            },
            sources = {
                { name = "nvim_lsp", priority = 8 },
                { name = "luasnip", option = { show_autosnippets = true }, priority = 7 },
                { name = "nvim_lua", priority = 5 },
                { name = "buffer", keyword_length = 5, priority = 7 },
                { name = "path", priority = 4 },
                --[[ { name = "npm", keyword_length = 4 }, ]]

                -- nvim_lsp_signature help will show the parameter name as autocomplete
                -- I have setup signature help to show in a popup window in the upper right hand
                -- corner instead, so this was not too helpful.

                --[[ { name = "nvim_lsp_signature_help" }, ]]
            },
            -- sorting = {
            --     priority_weight = 1.0,
            --     comparators = {
            --         compare.
            --         cmp.config.compare.offset,
            --         cmp.config.compare.exact,
            --         cmp.config.compare.score,
            --
            --         -- copied from cmp-under, but I don't think I need the plugin for this.
            --         -- I might add some more of my own.
            --         function(entry1, entry2)
            --             local _, entry1_under = entry1.completion_item.label:find "^_+"
            --             local _, entry2_under = entry2.completion_item.label:find "^_+"
            --             entry1_under = entry1_under or 0
            --             entry2_under = entry2_under or 0
            --             if entry1_under > entry2_under then
            --                 return false
            --             elseif entry1_under < entry2_under then
            --                 return true
            --             end
            --         end,
            --
            --         cmp.config.compare.kind,
            --         cmp.config.compare.sort_text,
            --         cmp.config.compare.length,
            --         cmp.config.compare.order,
            --     },
            -- },
            experimental = {
                ghost_text = true,
                native_menu = false,
            },

            require("luasnip/loaders/from_vscode").load(),
        }

        local autocomplete_group = vim.api.nvim_create_augroup("vimrc_autocompletion", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "sql", "mysql", "plsql" },
            callback = function()
                cmp.setup.buffer {
                    sources = {
                        { name = "vim-dadbod-completion" },
                        { name = "buffer" },
                        { name = "vsnip" },
                    },
                }
            end,
            group = autocomplete_group,
        })

        local present_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
        if not present_autopairs then
            return
        end

        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    end,
}
