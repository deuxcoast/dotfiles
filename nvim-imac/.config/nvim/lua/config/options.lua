--- Default Neovim Options
local opt = vim.opt
local g = vim.g

opt.laststatus = 3 -- use global statusline
opt.showmode = false -- Statusline does this for me
opt.showcmd = false -- don't show extra info at the end of hte command line
opt.clipboard = "unnamedplus" -- use '+' register for all yanks, and deletes, sync with system clipboard
opt.confirm = true -- confirm to save changes before closing modified buffer
opt.cursorline = true -- highlight current line
g.loaded_netrw = 1 -- don't load netrw. interferes with nvimtree ( setting this here might be redundant with nvimtree config)
g.loaded_netrwPlugin = 1 -- don't load netrw
vim.g.navic_silence = true -- supress error messages thrown by navic
opt.completeopt = { "menu", "menuone", "noselect" } -- better autocomplete options
opt.cmdheight = 1 -- only one line for commands
opt.encoding = "UTF-8"
opt.ignorecase = true -- case insensitive search. Use \C to enable case sensitive.
opt.inccommand = "nosplit" -- line preview of :s results
opt.incsearch = true -- do incremental searching
opt.mouse = "a" -- automatically enable mouse usage
opt.backup = false -- don't create backup files
opt.writebackup = false -- don't create backup files
--[[ opt.signcolumn = "yes" ]]
opt.signcolumn = "number" -- always show sign column. currently there is a visual desync when this is auto. (#14195)
opt.splitright = true -- open vertical splits right of the current one
opt.splitbelow = true -- open horizontal splits below the current one
opt.smartcase = true -- use case sensitive search if capital letter is present
opt.smarttab = true -- <tab><bs> indent/deindent in leading whitespace
opt.updatetime = 300
opt.undofile = true -- persists undo tree
opt.relativenumber = true -- show relative line numbers by default
opt.colorcolumn = "80" -- highlight colorcolumn in line 80 with hl-ColorColumn
opt.ttyfast = true -- let vim know that I am using a fast term

-- disable nvim intro
opt.shortmess:append("sI") -- avoid "Hit Enter" messages.
-- flag s: don't give "search hit BOTTOM, continuing at TOP" etc messages.
-- flag I: don't give intro message when starting Vim
-- :help shortmess for more flags

-- opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
--[[ opt.foldcolumn = "1" ]]
--[[ opt.foldlevel = 99 ]]
opt.foldlevelstart = 99 -- start unfolded
--[[ opt.foldenable = true ]]
--[[ opt.foldmethod = "expr" ]]
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.shell = "zsh" -- zsh as default shell
opt.termguicolors = true -- use 24 bit colors in tui
opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<,space:␣"

opt.wrap = false -- do not wrap text automatically
opt.whichwrap:append("<>[]hl")
opt.tabstop = 4 -- spaces per tab as editor default
opt.shiftwidth = 4 -- spaces per tab (when shifting)
opt.smartindent = true
opt.expandtab = true -- always use spaces instead of tabs
opt.timeoutlen = 300 -- number of ms to wait for a mapped sequence to complete

opt.number = true -- show numbers by default
opt.numberwidth = 2 -- minimal number of columns to use for line number column
opt.ruler = false -- don't show line, column number. status line does this for me

local autocmd = vim.api.nvim_create_autocmd

-- Dont list quickfix buffers
autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- wrap text in telescope previewer
-- ideally don't want this to be a global command, but only for specific previewers
-- such as :Telescope noice
vim.api.nvim_create_autocmd("User", {
	pattern = "TelescopePreviewerLoaded",
	command = "setlocal wrap",
})

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- get italic highlights to work with tmux // causing problems with
-- bufferline plugin.
-- https://gist.github.com/gutoyr/4192af1aced7a1b555df06bd3781a722
