return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "config.lsp"
        end,
    },
    "jose-elias-alvarez/null-ls.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require("mason-tool-installer").setup {
                auto_update = true,
                debounce_hours = 24,
                ensure_installed = {
                    "astro-language-server",
                    "bash-language-server",
                    "beautysh",
                    "black",
                    "chrome-debug-adapter",
                    "clang-format",
                    "clangd",
                    "codelldb",
                    "cpplint",
                    "cpptools",
                    "css-lsp",
                    "delve",
                    "deno",
                    "diagnostic-languageserver",
                    "dockerfile-language-server",
                    "emmet-ls",
                    "eslint-lsp",
                    "eslint-lsp",
                    "eslint_d",
                    "firefox-debug-adapter",
                    "gofumpt",
                    "goimports",
                    "golangci-lint-langserver",
                    "gopls",
                    "graphql-language-service-cli",
                    "html-lsp",
                    "isort",
                    "json-lsp",
                    "lua-language-server",
                    "markdownlint",
                    "marksman",
                    "prettierd",
                    "prisma-language-server",
                    "pyright",
                    "shellcheck",
                    "shfmt",
                    "sqlls",
                    "stylua",
                    "tailwindcss-language-server",
                    "typescript-language-server",
                    "yaml-language-server",
                },
            }
        end,
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
