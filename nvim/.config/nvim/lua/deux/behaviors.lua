-- ===========================================================================
-- Change vim behavior via autocommands
-- ===========================================================================

local uis = vim.api.nvim_list_uis()
local has_ui = #uis > 0

local groups = {}
local augroup = function(name, opts)
	if not groups[name] then
		opts = opts or {}
		groups[name] = vim.api.nvim_create_augroup(name, opts)
	end
	return groups[name]
end

local autocmd = vim.api.nvim_create_autocmd

if has_ui then
	-- @TODO keep an eye on https://github.com/neovim/neovim/issues/23581
	autocmd("WinLeave", {
		desc = "Toggle close->open loclist so it is always under the correct window",
		callback = function()
			if vim.bo.buftype == "quickfix" then
				-- Was in loclist already
				return
			end
			local loclist_winid = vim.fn.getloclist(0, { winid = 0 }).winid
			if loclist_winid == 0 then
				return
			end

			local leaving = vim.api.nvim_get_current_win()
			autocmd("WinEnter", {
				callback = function()
					if vim.bo.buftype == "quickfix" then
						-- Left main window and went into the loclist
						return
					end
					local entering = vim.api.nvim_get_current_win()
					vim.o.eventignore = "all"
					vim.api.nvim_set_current_win(leaving)
					vim.cmd.lclose()
					vim.cmd.lwindow()
					vim.api.nvim_set_current_win(entering)
					vim.o.eventignore = ""
				end,
				once = true,
			})
		end,
		group = augroup("deuxwindow"),
	})

	autocmd("VimResized", {
		desc = "Automatically resize windows in all tabpages when resizing Vim",
		callback = function()
			vim.schedule(function()
				vim.cmd("tabdo wincmd =")
			end)
		end,
		group = augroup("deuxwindow"),
	})

	autocmd("QuitPre", {
		desc = "Auto close corresponding loclist when quitting a window",
		callback = function()
			if vim.bo.filetype ~= "qf" then
				vim.cmd("silent! lclose")
			end
		end,
		nested = true,
		group = augroup("deuxwindow"),
	})

	autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
		desc = "Start in insert mode when entering a terminal",
		callback = function(args)
			if vim.startswith(vim.api.nvim_buf_get_name(args.buf), "term://") then
				vim.cmd("startinsert")
			end
		end,
		group = augroup("deuxwindow"),
	})

	autocmd("BufReadPre", {
		desc = "Disable linting and syntax highlighting for large and minified files",
		callback = function(args)
			-- See the treesitter highlight config too
			if require("deux.utils.buffer").is_huge(args.file) then
				vim.cmd.syntax("manual")
			end
		end,
		group = augroup("deuxreading"),
	})

	autocmd("BufReadPre", {
		pattern = "*.min.*",
		desc = "Disable syntax on minified files",
		command = "syntax manual",
		group = augroup("deuxreading"),
	})

	-- https://vi.stackexchange.com/questions/11892/populate-a-git-commit-template-with-variables
	autocmd("BufRead", {
		pattern = "COMMIT_EDITMSG",
		desc = "Replace tokens in commit-template",
		callback = function()
			local tokens = {}
			tokens.BRANCH = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }):wait().stdout:gsub("\n", "")

			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			for i, line in ipairs(lines) do
				lines[i] = line:gsub("%$%{(%w+)%}", function(s)
					return s:len() > 0 and tokens[s] or ""
				end)
			end
			vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
		end,
		group = augroup("deuxreading"),
	})

	autocmd("BufEnter", {
		desc = "Read only mode (un)mappings",
		callback = function()
			local is_editable = require("deux.utils.buffer").is_editable
			if is_editable(0) then
				return
			end

			local closebuf = function()
				if is_editable(0) then
					return
				end
				local totalWindows = vim.fn.winnr("$")
				if totalWindows > 1 then
					vim.cmd.close()
				else
					-- Requires nobuflisted on quickfix!
					vim.cmd.bprevious()
				end
			end
			vim.keymap.set("n", "Q", closebuf, { buffer = true })
			vim.keymap.set("n", "q", closebuf, { buffer = true })
		end,
		group = augroup("deuxreading"),
	})

	-- yank into system clipboard
	autocmd({ "BufReadPost", "BufNewFile" }, {
		once = true,
		callback = function()
			if vim.fn.has("mac") == 1 then
				vim.g.clipboard = {
					copy = {
						["+"] = "pbcopy",
						["*"] = "pbcopy",
					},
					paste = {
						["+"] = "pbpaste",
						["*"] = "pbpaste",
					},
				}
			elseif vim.fn.has("unix") == 1 then
				if vim.fn.executable("xclip") == 1 then
					vim.g.clipboard = {
						copy = {
							["+"] = "xclip -selection clipboard",
							["*"] = "xclip -selection clipboard",
						},
						paste = {
							["+"] = "xclip -selection clipboard -o",
							["*"] = "xclip -selection clipboard -o",
						},
					}
				elseif vim.fn.executable("xsel") == 1 then
					vim.g.clipboard = {
						copy = {
							["+"] = "xsel --clipboard --input",
							["*"] = "xsel --clipboard --input",
						},
						paste = {
							["+"] = "xsel --clipboard --output",
							["*"] = "xsel --clipboard --output",
						},
					}
				end
			end
			-- vim.opt.clipboard = "unnamedplus"
		end,
	})
end
