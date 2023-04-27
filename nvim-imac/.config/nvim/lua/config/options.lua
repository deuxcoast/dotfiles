--- Default Neovim Options
local opt = vim.opt
local g = vim.g

-- Global Status line
opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.clipboard = "unnamedplus"
opt.cursorline = true
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
vim.g.navic_silence = true                          -- supress error messages thrown by navic
opt.completeopt = { "menu", "menuone", "noselect" } -- better autocomplete options
opt.cmdheight = 1                                   -- only one line for commands
opt.encoding = "UTF-8"
opt.ignorecase = true                               -- case insensitive search. Use \C to enable case sensitive.
opt.inccommand = "nosplit"
opt.incsearch = true
opt.mouse = "a"
opt.backup = false      -- don't create backup files
opt.writebackup = false -- don't create backup files
opt.signcolumn = "yes"
opt.splitright = true   -- splits to the right
opt.splitbelow = true   -- splits below
opt.updatetime = 300
opt.undofile = true     -- persists undo tree
opt.relativenumber = true
opt.colorcolumn = "80"

-- disable nvim intro
opt.shortmess:append("sI")

-- opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
--[[ opt.foldcolumn = "1" ]]
--[[ opt.foldlevel = 99 ]]
--[[ opt.foldlevelstart = 99 ]]
--[[ opt.foldenable = true ]]
--[[ opt.foldmethod = "expr" ]]
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.shell = "zsh"
opt.termguicolors = true
opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<,space:␣"

opt.wrap = false
opt.whichwrap:append("<>[]hl")
opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.expandtab = true
opt.timeoutlen = 400

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

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
