local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
    return
end

local imap = require("config.mapping").imap
local nmap = require("config.mapping").nmap
local autocmd = require("config.auto").autocmd
local autocmd_clear = vim.api.nvim_clear_autocmds

local handlers = require "config.lsp.handlers"

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
}

-- Defining signs
for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local ts_util = require "nvim-lsp-ts-utils"
local inlays = require "config.lsp.inlay"

local custom_init = function(client)
    client.config.flags = client.config.flags or {}
    client.config.flags.allow_incremental_sync = true
end

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_codelens = vim.api.nvim_create_augroup("custom-lsp-codelens", { clear = true })
local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })
local augroup_semantic = vim.api.nvim_create_augroup("custom-lsp-semantic", { clear = true })

-- local autocmd_format = function(async, filter)
--     vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
--     vim.api.nvim_create_autocmd("BufWritePre", {
--         buffer = 0,
--         callback = function()
--             vim.lsp.buf.format { async = async, filter = filter }
--         end,
--     })
-- end
--
-- local filetype_attach = setmetatable({
--     clojure_lsp = function()
--         autocmd_format(false)
--     end,
--     c = function()
--         autocmd_format(false)
--     end,
--
--     ocaml = function()
--         autocmd_format(false)
--
--         -- Display type information
--         autocmd_clear { group = augroup_codelens, buffer = 0 }
--         autocmd {
--             { "BufEnter", "BufWritePost", "CursorHold" },
--             augroup_codelens,
--             require("config.lsp.codelens").refresh_virtlines,
--             0,
--         }
--
--         vim.keymap.set(
--             "n",
--             "<space>tt",
--             require("config.lsp.codelens").toggle_virtlines,
--             { silent = true, desc = "[T]oggle [T]ypes", buffer = 0 }
--         )
--     end,
--
--     ruby = function()
--         autocmd_format(false)
--     end,
--
--     go = function()
--         autocmd_format(false)
--     end,
--
--     scss = function()
--         autocmd_format(false)
--     end,
--
--     css = function()
--         autocmd_format(false)
--     end,
--
--     rust = function()
--         -- telescope_mapper("<space>wf", "lsp_workspace_symbols", {
--         --     ignore_filename = true,
--         --     query = "#",
--         -- }, true)
--
--         autocmd_format(false)
--     end,
--
--     racket = function()
--         autocmd_format(false)
--     end,
--
--     typescript = function()
--         -- autocmd_format(false)
--         autocmd_format(false, function(client)
--             return client.name ~= "tsserver"
--         end)
--     end,
--
--     javascript = function()
--         autocmd_format(false, function(client)
--             return client.name ~= "tsserver"
--         end)
--     end,
--
--     python = function()
--         autocmd_format(false)
--     end,
-- }, {
--     __index = function()
--         return function() end
--     end,
-- })

local buf_nnoremap = function(opts)
    if opts[3] == nil then
        opts[3] = {}
    end
    opts[3].buffer = 0

    nmap(opts)
end

local buf_inoremap = function(opts)
    if opts[3] == nil then
        opts[3] = {}
    end
    opts[3].buffer = 0

    imap(opts)
end

local custom_attach = function(client, bufnr)
    if client.name == "copilot" then
        return
    end

    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }

    buf_nnoremap { "<space>cr", vim.lsp.buf.rename, { desc = "Rename variable" } }
    buf_nnoremap { "<space>ca", vim.lsp.buf.code_action, { desc = "Code action" } }

    buf_nnoremap { "gd", vim.lsp.buf.definition, { desc = "Symbol definition" } }
    buf_nnoremap { "gD", vim.lsp.buf.declaration, { desc = "Symbol declaration" } }
    buf_nnoremap { "gT", vim.lsp.buf.type_definition, { desc = "Type definition" } }
    buf_nnoremap { "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }

    buf_nnoremap { "<space>gI", handlers.implementation, { desc = "Symbol Implementation" } }
    buf_nnoremap { "<space>rr", "LspRestart", { desc = "LSP restart" } }

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        autocmd_clear { group = augroup_highlight, buffer = bufnr }
        autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, bufnr }
        autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, bufnr }
    end

    if false and client.server_capabilities.codeLensProvider then
        if filetype ~= "elm" then
            autocmd_clear { group = augroup_codelens, buffer = bufnr }
            autocmd { "BufEnter", augroup_codelens, vim.lsp.codelens.refresh, bufnr, once = true }
            autocmd { { "BufWritePost", "CursorHold" }, augroup_codelens, vim.lsp.codelens.refresh, bufnr }
        end
    end

    if filetype == "typescript" or filetype == "lua" then
        client.server_capabilities.semanticTokensProvider = nil
    end

    -- Attach any filetype specific options to the client
    -- TODO: implement custom ft attach function
    -- filetype_attach[filetype]()
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

-- Completion configuration
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

local servers = {
    bashls = true,
    lua_ls = {
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { "vim" },
                },
                workspace = {
                    -- make the server aware of Neovim runtime files
                    -- checkThirdParty = false,
                    library = {
                        -- vim.env.VIMRUNTIME,
                        vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        },
    },

    gdscript = true,
    -- graphql = true,
    html = true,
    pyright = true,
    vimls = true,
    yamlls = true,
    ocamllsp = {
        -- cmd = { "/home/duexcoast/git/ocaml-lsp/_build/default/ocaml-lsp-server/bin/main.exe" },
        settings = {
            codelens = { enable = true },
        },

        get_language_id = function(_, ftype)
            return ftype
        end,
    },

    clojure_lsp = true,

    -- Enable jsonls with json schemas
    jsonls = {
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    },

    -- TODO: Test the other Ruby LSPs?
    -- solargraph = { cmd = { "bundle", "exec", "solargraph", "stdio" } },
    -- sorbet = true,

    cmake = (1 == vim.fn.executable "cmake-language-server"),
    dartls = pcall(require, "flutter-tools"),

    clangd = {
        -- additional config in ~/Library/Preferences/clangd/config.yaml
        -- This is where clangd looks for additional flags to be added
        -- Currently setup for maximum diagnostics
        cmd = {
            "clangd",
            "--enable-config",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--offset-encoding=utf-16", --temporary fix for null-ls
        },
        init_options = {
            clangdFileStatus = true,
        },
        filetypes = {
            "h",
            "c",
            "cpp",
            "cc",
            "objc",
            "objcpp",
        },
        single_file_support = true,
        root_dir = lspconfig.util.root_pattern(
            ".clangd",
            ".clang-tidy",
            ".clang-format",
            "compile_commands.json",
            "compile_flags.txt",
            "configure.ac",
            ".git"
        ),
    },

    svelte = true,

    gopls = {
        settings = {
            gopls = {
                codelenses = {
                    test = true,
                    -- gc_details = true,
                },
                hints = inlays and {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                } or nil,
            },
        },

        flags = {
            debounce_text_changes = 200,
        },
    },

    omnisharp = {
        cmd = { vim.fn.expand "~/build/omnisharp/run", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    },

    -- rust_analyzer = rust_analyzer,

    racket_langserver = true,

    elmls = true,
    cssls = true,
    perlnavigator = true,

    -- nix language server
    nil_ls = true,

    tailwindcss = {
        filetypes = { "css", "typescript" },
    },
}

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "astro",
        "bashls",
        "cssls",
        "dockerls",
        "eslint",
        "gopls",
        "graphql",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "sqlls",
        "tailwindcss",
        "tsserver",
        "vimls",
        "yamlls",
    },
}

local setup_server = function(server, config)
    if not config then
        return
    end

    if type(config) ~= "table" then
        config = {}
    end

    config = vim.tbl_deep_extend("force", {
        on_init = custom_init,
        on_attach = custom_attach,
        capabilities = updated_capabilities,
    }, config)

    lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
    setup_server(server, config)
end

-- local prettier = { "prettierd", "prettier", stop_after_first = true }
-- require("conform").setup {
--     format_on_save = {
--         -- These options will be passed to conform.format()
--         timeout_ms = 500,
--         lsp_format = "fallback",
--     },
--     formatters_by_ft = {
--         javascript = prettier,
--         typescript = prettier,
--         javascriptreact = prettier,
--         typescriptreact = prettier,
--         css = prettier,
--         graphql = prettier,
--         html = prettier,
--         json = prettier,
--         json5 = prettier,
--         jsonc = prettier,
--         yaml = prettier,
--         markdown = function(bufnr)
--             return { first(bufnr, "prettierd", "prettier"), "injected" }
--         end,
--         lua = { "stylua" },
--         c = { "clang-format" },
--         cpp = { "clang-format" },
--         go = { "goimports", "gofmt" },
--         python = { "isort", "black" },
--         sh = { "shmft", "shellharden" },
--     },
--     formatters = {
--         ["clang-format"] = {
--             prepend_args = {
--                 "--style",
--                 "{BasedOnStyle: Chromium, IndentWidth: 4, ColumnLimit: 80, AlignTrailingComments: true, BraceWrapping: {AfterFunction: false}}",
--             },
--         },
--     },
-- }
-- require("null-ls").setup {
--     sources = {
--         require("null-ls").builtins.formatting.stylua,
--         require("null-ls").builtins.diagnostics.eslint_d,
--         require("null-ls").builtins.formatting.beautysh,
--         require("null-ls").builtins.formatting.prettierd,
--         require("null-ls").builtins.formatting.isort,
--         require("null-ls").builtins.formatting.black,
--         require("null-ls").builtins.formatting.goimports,
--         require("null-ls").builtins.formatting.clang_format.with {
--             command = "clang-format",
--             extra_args = {
--                 "--style",
--                 "--                 "{BasedOnStyle: Chromium, IndentWidth: 4, ColumnLimit: 80, AlignTrailingComments: true, BraceWrapping: {AfterFunction: false}}",",
--             },
--             filetypes = { "c", "cpp" },
--         },
--     },
--     on_attach = function(client, bufnr)
--         if client.supports_method "textDocument/formatting" then
--             vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
--             vim.api.nvim_create_autocmd("BufWritePre", {
--                 group = augroup,
--                 buffer = bufnr,
--                 callback = function()
--                     -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
--                     -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
--                     -- vim.lsp.buf.formatting_sync()
--                     vim.lsp.buf.format {
--                         bufnr = bufnr,
--                         filter = function(client)
--                             return client.name == "null-ls"
--                         end,
--                     }
--                 end,
--             })
--         end
--     end,
-- }

return {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
}
