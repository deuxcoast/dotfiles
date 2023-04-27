local present, _ = pcall(require, "lspconfig")
if not present then
	return
end

local presentMason, mason = pcall(require, "mason")
if not presentMason then
	return
end

mason.setup()

local servers = {
	-- LSP servers
	"astro-language-server",
	"bash-language-server",
	"clangd",
	"css-lsp",
	"diagnostic-languageserver",
	"dockerfile-language-server",
	"eslint-lsp",
	"golangci-lint-langserver",
	"gopls",
	"graphql-language-service-cli",
	"html-lsp",
	"json-lsp",
	"lua-language-server",
	"prisma-language-server",
	--[[ "rust-analyzer", ]]
	"sqlls",
	"stylua",
	--[[ "stylelint-lsp", ]]
	"svelte-language-server",
	"tailwindcss-language-server",
	"typescript-language-server",
	"yaml-language-server",
	"marksman",
	--[[ "texlab", ]]
	--[[ "ltex-ls", ]]

	-- DAP
	"delve",
	-- "node-debug2-adapter",
	"firefox-debug-adapter",
	"chrome-debug-adapter",

	-- linters
	"eslint_d",
	"shellcheck",
	--[[ "cspell", ]]

	-- formatters
	"prettierd",
	"shfmt",
}

for _, server_name in pairs(servers) do
	if not require("mason-registry").is_installed(server_name) then
		vim.cmd("MasonInstall " .. server_name)
	end
end

local handlers = require("config.lsp.handlers")
handlers.setup()

-- Settings for Floating Hover / Preview window
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "single"
	opts.max_width = opts.max_width or 95
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- This gets lines between code blocks in the floating preview window
--[[ local orig_stylize_markdown = vim.lsp.util.stylize_markdown ]]
--[[ function vim.lsp.util.stylize_markdown(bufnr, contents, opts, ...) ]]
--[[     opts = opts or {} ]]
--[[     opts.separator = true ]]
--[[     opts.border = "rounded" ]]
--[[     opts.max_width = 95 ]]
--[[     return orig_stylize_markdown(bufnr, contents, opts, ...) ]]
--[[ end ]]
local on_attach = handlers.on_attach
local capabilities = handlers.capabilities

require("config.lsp.servers").setup(on_attach, capabilities)
require("config.lsp.servers.tsserver").setup()
require("config.lsp.servers.null_ls").setup(on_attach)
require("config.lsp.servers.ls_emmet").setup(capabilities)
