return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
		"abecodes/tabout.nvim",
		--[[ { "tzachar/cmp-tabnine", build = "./install.sh" }, ]]
	},
	config = function()
		local presentCmp, cmp = pcall(require, "cmp")
		local present_lua_snip, ls = pcall(require, "luasnip")
		local lspkind = require("lspkind")

		local winhighlight = {
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel",
		}

		vim.cmd("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
		vim.cmd("highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6")
		vim.cmd("highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6")
		vim.cmd("highlight! CmpItemKindField guibg=NONE guifg=#ff7eb6")
		vim.cmd("highlight! CmpItemKindProperty guibg=NONE guifg=#ff7eb6")
		vim.cmd("highlight! CmpItemKindConstant guibg=NONE guifg=#ff7eb6")
		vim.cmd("highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE")
		vim.cmd("highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE")
		vim.cmd("highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE")
		vim.cmd("highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0")
		vim.cmd("highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0")
		vim.cmd("highlight! CmpItemKindStruct guibg=NONE guifg=#ffe97b")
		vim.cmd("highlight! CmpItemKindClass guibg=NONE guifg=#ffe97b")
		vim.cmd("highlight! CmpItemKindModule guibg=NONE guifg=#42be65")
		vim.cmd("highlight! CmpItemKindSnippet guibg=NONE guifg=#42be65")
		vim.cmd("highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4")
		vim.cmd("highlight! CmpItemKindFile guibg=NONE guifg=#be95ff")

		local types = require("cmp.types")
		local str = require("cmp.utils.str")

		local icons = {
			Text = "",
			Method = "",
			Function = "",
			Constructor = "⌘",
			Field = "ﰠ",
			Variable = "",
			Class = "ﴯ",
			Interface = "",
			Module = "",
			Property = "ﰠ",
			Unit = "塞",
			Value = "",
			Enum = "",
			Keyword = "廓",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "פּ",
			Event = "",
			Operator = "",
			TypeParameter = "",
		}

		if not presentCmp or not present_lua_snip then
			return
		end

		cmp.setup({
			snippet = {
				expand = function(args)
					ls.lsp_expand(args.body)
				end,
			},
			completion = {
				completeopt = "menu,menuone,noselect",
			},
			enabled = function()
				buftype = vim.api.nvim_buf_get_option(0, "buftype")
				if buftype == "prompt" then
					return false
				end
				-- disable completion in comments
				local context = require("cmp.config.context")
				-- keep command mode completion enabled when cursor is in a comment
				if vim.api.nvim_get_mode().mode == "c" then
					return true
				else
					return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
				end
			end,
			mapping = {
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping(
					cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					{ "i", "c" }
				),
				["<M-y>"] = cmp.mapping(
					cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					{ "i", "c" }
				),
				["<c-space>"] = cmp.mapping({
					i = cmp.mapping.complete(),
					c = function(
						_ --[[fallback]]
					)
						if cmp.visible() then
							if not cmp.confirm({ select = true }) then
								return
							end
						else
							cmp.complete()
						end
					end,
				}),
				["<tab>"] = cmp.config.disable,

				-- Maybe?
				["<c-q>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
			},
			window = {
				completion = cmp.config.window.bordered(winhighlight),
				documentation = cmp.config.window.bordered(winhighlight),
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 60,
					before = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "ﲳ",
							nvim_lua = "",
							treesitter = "",
							path = "ﱮ",
							buffer = "﬘",
							zsh = "",
							vsnip = "",
							npm = "暈",
						})[entry.source.name]

						-- Get the full snippet (and only keep first line)
						local word = entry:get_insert_text()
						if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
							word = vim.lsp.util.parse_snippet(word)
						end
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
				}),
			},
			sources = {
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				--[[ { name = "npm", keyword_length = 4 }, ]]
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer", keyword_length = 5 },

				-- nvim_lsp_signature help will show the parameter name as autocomplete
				-- I have setup signature help to show in a popup window in the upper right hand
				-- corner instead, so this was not too helpful.

				--[[ { name = "nvim_lsp_signature_help" }, ]]
			},
			experimental = {
				ghost_text = true,
				native_menu = false,
			},

			-- TEST: I Don't know if this was needed. Giving it a test drive without it

			--[[ performance = { throttle = 300 }, ]]
			-- preselect = cmp.PreselectMode.None,
		})
		--
		-- 	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
		-- 	cmp.setup.cmdline("/", {
		-- 		mapping = cmp.mapping.preset.cmdline(),
		-- 		sources = { { name = "buffer" } },
		-- 	})
		--
		-- 	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		-- 	cmp.setup.cmdline(":", {
		-- 		mapping = cmp.mapping.preset.cmdline(),
		-- 		sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
		-- 	})
		--
		local present_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
		if not present_autopairs then
			return
		end

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
	end,
}
