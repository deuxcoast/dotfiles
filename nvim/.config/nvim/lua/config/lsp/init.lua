local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
    return
end

local imap = require("duex.keymap").imap
local nmap = require("duex.keymap").nmap
local autocmd = require("duex.auto").autocmd
local autocmd_clear = vim.api.nvim_clear_autocmds

-- local is_mac = vim.fn.has "macunix" == 1

-- local telescope_mapper = require "duex.telescope.mappings"
local handlers = require "config.lsp.handlers"

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    -- { name = "DiagnosticSignInfo", text = "" },
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

local autocmd_format = function(async, filter)
    vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = 0,
        callback = function()
            vim.lsp.buf.format { async = async, filter = filter }
        end,
    })
end

local filetype_attach = setmetatable({
    clojure_lsp = function()
        autocmd_format(false)
    end,
    c = function()
        autocmd_format(false)
    end,

    ocaml = function()
        autocmd_format(false)

        -- Display type information
        autocmd_clear { group = augroup_codelens, buffer = 0 }
        autocmd {
            { "BufEnter", "BufWritePost", "CursorHold" },
            augroup_codelens,
            require("config.lsp.codelens").refresh_virtlines,
            0,
        }

        vim.keymap.set(
            "n",
            "<space>tt",
            require("config.lsp.codelens").toggle_virtlines,
            { silent = true, desc = "[T]oggle [T]ypes", buffer = 0 }
        )
    end,

    ruby = function()
        autocmd_format(false)
    end,

    go = function()
        autocmd_format(false)
    end,

    scss = function()
        autocmd_format(false)
    end,

    css = function()
        autocmd_format(false)
    end,

    rust = function()
        telescope_mapper("<space>wf", "lsp_workspace_symbols", {
            ignore_filename = true,
            query = "#",
        }, true)

        autocmd_format(false)
    end,

    racket = function()
        autocmd_format(false)
    end,

    typescript = function()
        -- autocmd_format(false)
        autocmd_format(false, function(client)
            return client.name ~= "tsserver"
        end)
    end,

    javascript = function()
        autocmd_format(false, function(client)
            return client.name ~= "tsserver"
        end)
    end,

    python = function()
        autocmd_format(false)
    end,
}, {
    __index = function()
        return function() end
    end,
})

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

    buf_nnoremap { "<space>cr", vim.lsp.buf.rename, { desc = "rename variable" } }
    buf_nnoremap { "<space>ca", vim.lsp.buf.code_action, { desc = "code action" } }

    buf_nnoremap { "gd", vim.lsp.buf.definition, { desc = "Symbol definition" } }
    buf_nnoremap { "gD", vim.lsp.buf.declaration, { desc = "Symbol declaration" } }
    buf_nnoremap { "gT", vim.lsp.buf.type_definition, { desc = "Type definition" } }
    buf_nnoremap { "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }

    buf_nnoremap { "<space>gI", handlers.implementation }
    -- buf_nnoremap { "<space>lr", "<cmd>lua R('config.lsp.codelens').run()<CR>" }
    buf_nnoremap { "<space>rr", "LspRestart" }

    -- telescope_mapper("gr", "lsp_references", nil, true)
    -- telescope_mapper("gI", "lsp_implementations", nil, true)
    -- telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
    -- telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

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
    filetype_attach[filetype]()
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

-- Completion configuration
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

local servers = {
    -- Also uses `shellcheck` and `explainshell`
    bashls = true,
    lua_ls = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            -- make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
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
        -- root_dir = function(fname)
        --   local Path = require "plenary.path"
        --
        --   local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
        --   local absolute_fname = Path:new(fname):absolute()
        --
        --   if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
        --     return absolute_cwd
        --   end
        --
        --   return lspconfig_util.root_pattern("go.mod", ".git")(fname)
        -- end,

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

    -- eslint = true,
    -- FIX: Commenting our the intialization of tsserver here while
    -- I test out `typescript.nvim`. lspconfig doesn't allow more than
    -- one setup call per server.
    --
    -- tsserver = {
    --     init_options = ts_util.init_options,
    --     cmd = { "typescript-language-server", "--stdio" },
    --     filetypes = {
    --         "javascript",
    --         "javascriptreact",
    --         "javascript.jsx",
    --         "typescript",
    --         "typescriptreact",
    --         "typescript.tsx",
    --     },
    --
    --     on_attach = function(client)
    --         custom_attach(client)
    --
    --         ts_util.setup { auto_inlay_hints = false }
    --         ts_util.setup_client(client)
    --     end,
    -- },
    tailwindcss = true,
}

-- if vim.fn.executable "llmsp" == 1 and vim.env.SRC_ACCESS_TOKEN then
--   vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
--     pattern = { "*" },
--     callback = function()
--       vim.lsp.start {
--         name = "llmsp",
--         cmd = { "llmsp" },
--         root_dir = vim.fs.dirname(vim.fs.find({ "go.mod", ".git" }, { upward = true })[1]),
--         capabilities = updated_capabilities,
--         on_attach = custom_attach,
--         settings = {
--           llmsp = {
--             sourcegraph = {
--               url = vim.env.SRC_ENDPOINT,
--               accessToken = vim.env.SRC_ACCESS_TOKEN,
--             },
--           },
--         },
--       }
--     end,
--   })
-- end

-- Can remove later if not installed (TODO: enable for not linux)
if vim.fn.executable "tree-sitter-grammar-lsp-linux" == 1 then
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "grammar.js", "*/corpus/*.txt" },
        callback = function()
            vim.lsp.start {
                name = "tree-sitter-grammar-lsp",
                cmd = { "tree-sitter-grammar-lsp-linux" },
                root_dir = "/",
                capabilities = updated_capabilities,
                on_attach = custom_attach,
            }
        end,
    })
end

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
    -- automatic_installation =
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

--[ An example of using functions...
-- 0. nil -> do default (could be enabled or disabled)
-- 1. false -> disable it
-- 2. true -> enable, use defaults
-- 3. table -> enable, with (some) overrides
-- 4. function -> can return any of above
--
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, method, params, client_id, bufnr, config)
--   local uri = params.uri
--
--   vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--       underline = true,
--       virtual_text = true,
--       signs = sign_decider,
--       update_in_insert = false,
--     }
--   )(err, method, params, client_id, bufnr, config)
--
--   bufnr = bufnr or vim.uri_to_bufnr(uri)
--
--   if bufnr == vim.api.nvim_get_current_buf() then
--     vim.lsp.diagnostic.set_loclist { open_loclist = false }
--   end
-- end
--]]

-- local async_formatting = function(bufnr)
--     bufnr = bufnr or vim.api.nvim_get_current_buf()
--
--     vim.lsp.buf_request(
--         bufnr,
--         "textDocument/formatting",
--         vim.lsp.util.make_formatting_params {},
--         function(err, res, ctx)
--             if err then
--                 local err_msg = type(err) == "string" and err or err.message
--                 -- you can modify the log message / level (or ignore it completely)
--                 -- vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
--                 return
--             end
--
--             -- don't apply results if buffer is unloaded or has been modified
--             if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
--                 return
--             end
--
--             if res then
--                 local client = vim.lsp.get_client_by_id(ctx.client_id)
--                 vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
--                 vim.api.nvim_buf_call(bufnr, function()
--                     vim.cmd "silent noautocmd update"
--                 end)
--             end
--         end
--     )
-- end

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup {
    sources = {
        -- require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint_d,
        require("null-ls").builtins.formatting.beautysh,
        require("null-ls").builtins.formatting.prettierd,
        require("null-ls").builtins.formatting.isort,
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.goimports,
        require("null-ls").builtins.formatting.clang_format.with {
            command = "clang-format",
            extra_args = {
                "--style",
                "{BasedOnStyle: Chromium, IndentWidth: 4, ColumnLimit: 80, AlignTrailingComments: true, BraceWrapping: {AfterFunction: false}}",
            },
            filetypes = { "c", "cpp" },
        },
    },
    on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                    -- vim.lsp.buf.formatting_sync()
                    vim.lsp.buf.format {
                        bufnr = bufnr,
                        filter = function(client)
                            return client.name == "null-ls"
                        end,
                    }
                end,
            })
        end
    end,
}

return {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
}
