local methods = vim.lsp.protocol.Methods
local md_namespace = vim.api.nvim_create_namespace("deuxcoast/lsp_float")

--- Adds extra inline highlights to the given buffer.
---@param buf integer
local function add_inline_highlights(buf)
	for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
		for pattern, hl_group in pairs({
			["@%S+"] = "@parameter",
			["^%s*(Parameters:)"] = "@text.title",
			["^%s*(Return:)"] = "@text.title",
			["^%s*(See also:)"] = "@text.title",
			["{%S-}"] = "@parameter",
			["|%S-|"] = "@text.reference",
		}) do
			local from = 1 ---@type integer?
			while from do
				local to
				from, to = line:find(pattern, from)
				if from then
					vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
						end_col = to,
						hl_group = hl_group,
					})
				end
				from = to and to + 1 or nil
			end
		end
	end
end

--- LSP handler that adds extra inline highlights, keymaps, and window options.
--- Code inspired from `noice`.
---@param handler fun(err: any, result: any, ctx: any, config: any): integer?, integer?
---@param focusable boolean
---@return fun(err: any, result: any, ctx: any, config: any)
local function enhanced_float_handler(handler, focusable)
	return function(err, result, ctx, config)
		local bufnr, winnr = handler(
			err,
			result,
			ctx,
			vim.tbl_deep_extend("force", config or {}, {
				border = require("deux.settings").get("border"),
				focusable = focusable,
				max_height = math.floor(vim.o.lines * 0.5),
				max_width = math.floor(vim.o.columns * 0.4),
			})
		)

		if not bufnr or not winnr then
			return
		end

		-- Conceal everything.
		vim.wo[winnr].concealcursor = "n"

		-- Extra highlights.
		add_inline_highlights(bufnr)

		-- Add keymaps for opening links.
		if focusable and not vim.b[bufnr].markdown_keys then
			vim.keymap.set("n", "K", function()
				-- Vim help links.
				local url = (vim.fn.expand("<cWORD>") --[[@as string]]):match("|(%S-)|")
				if url then
					return vim.cmd.help(url)
				end

				-- Markdown links.
				local col = vim.api.nvim_win_get_cursor(0)[2] + 1
				local from, to
				from, to, url = vim.api.nvim_get_current_line():find("%[.-%]%((%S-)%)")
				if from and col >= from and col <= to then
					vim.system({ "xdg-open", url }, nil, function(res)
						if res.code ~= 0 then
							vim.notify("Failed to jpen URL" .. url, vim.log.levels.ERROR)
						end
					end)
				end
			end, { buffer = bufnr, silent = true })
			vim.b[bufnr].markdown_keys = true
		end
	end
end
vim.lsp.handlers[methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover, true)
vim.lsp.handlers[methods.textDocument_signatureHelp] = enhanced_float_handler(vim.lsp.handlers.signature_help, false)

--- HACK: Override `vim.lsp.util.stylize_markdown` to use Treesitter.
---@param bufnr integer
---@param contents string[]
---@param opts table
---@return string[]
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
	contents = vim.lsp.util._normalize_markdown(contents, {
		width = vim.lsp.util._make_floating_popup_size(contents, opts),
	})
	vim.bo[bufnr].filetype = "markdown"
	vim.treesitter.start(bufnr)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

	add_inline_highlights(bufnr)

	return contents
end
