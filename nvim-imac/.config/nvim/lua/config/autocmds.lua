local function augroup(name)
	return vim.api.nvim_create_augroup("coast_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- Check if file changed when its window is focus, more eager than 'autoread'
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Dont list quickfix buffers
autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- Highlight yanked text
autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- wrap text in telescope previewer
-- ideally don't want this to be a global command, but only for specific previewers
-- such as :Telescope noice
autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	command = "setlocal wrap",
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- match trailing whitespace when in normal mode
local group_trailing_whitespace = augroup("trailing_whitespace")
autocmd({ "BufWinEnter", "InsertEnter" }, {
	group = group_trailing_whitespace,
	command = "match Error /\\s\\+%#@<!$/",
})

-- unmatch trailing whitespace when in inser mode
autocmd({ "InsertLeave" }, {
	group = augroup("trailing_whitespace"),
	command = "match Error /\\s\\+$/",
})

-- close some filetypes with <C-c>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"nvimtree",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "<C-c>", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end
