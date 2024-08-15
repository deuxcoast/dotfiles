return {
    "jose-elias-alvarez/typescript.nvim",
    event = "VeryLazy",
    config = function()
        ts_util = require "nvim-lsp-ts-utils"
        require("typescript").setup {
            server = {
                init_options = ts_util.init_options,
                cmd = { "typescript-language-server", "--stdio" },
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                },
            },
        }
    end,
}
