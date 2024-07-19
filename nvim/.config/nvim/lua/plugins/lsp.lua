return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "config.lsp"
        end,
    },
    "jose-elias-alvarez/null-ls.nvim",
    {
        "williamboman/mason.nvim",
        event = "User FilePost",
        cmd = {
            "Mason",
            "MasonInstall",
            "MasonInstallAll",
            "MasonUpdate",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonLog",
        },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            {
                "jay-babu/mason-nvim-dap.nvim",
                config = function()
                    require("mason-nvim-dap").setup {
                        automatic_installation = true,
                    }
                end,
            },
            {
                "jay-babu/mason-null-ls.nvim",

                -- dependencies = {
                --     "williamboman/mason.nvim",
                --     "jose-elias-alvarez/null-ls.nvim",
                -- },
                config = function()
                    require("mason-null-ls").setup {
                        ensure_installed = {
                            "delve",
                            "chrome-debug-adapter",
                            "firefox-debug-adapter",
                            "debugpy",
                            "js-debug-adapter",
                        },
                    }
                end,
            },
            {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                config = function()
                    require("mason-tool-installer").setup {
                        auto_update = true,
                        debounce_hours = 24,
                        ensure_installed = {
                            "beautysh",
                            "black",
                            "debugpy",
                            "clangd",
                            "codelldb",
                            "cpplint",
                            "cpptools",
                            "isort",
                            "marksman",
                            "shellcheck",
                            "shfmt",
                            "stylua",
                        },
                    }
                end,
            },
        },
    },
    -- lazydev will automatically configure lua_ls for editing neovim config
    -- it will lazily upload workspace libraries
    -- {
    --     "folke/lazydev.nvim",
    --     ft = "lua", -- only load on lua files
    --     opts = {
    --         library = {
    --             -- See the configuration section for more details
    --             -- Load luvit types when the `vim.uv` word is found
    --             { path = "luvit-meta/library", words = { "vim%.uv" } },
    --         },
    --     },
    -- },
    -- { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    -- { -- optional completion source for require statements and module annotations
    --     "hrsh7th/nvim-cmp",
    --     opts = function(_, opts)
    --         opts.sources = opts.sources or {}
    --         table.insert(opts.sources, {
    --             name = "lazydev",
    --             group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    --         })
    --     end,
    -- },
    "simrat39/inlay-hints.nvim",
    { "j-hui/fidget.nvim", branch = "legacy" },
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    "b0o/schemastore.nvim",
}
