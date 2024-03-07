--- Default Neovim Options
local g = vim.g

g.loaded_netrw = 1 -- don't load netrw. interferes with nvimtree ( setting this here might be redundant with nvimtree config)
g.loaded_netrwPlugin = 1 -- don't load netrw
g.netrw_nogx = 1 -- just to be thorough
g.navic_silence = true -- supress error messages thrown by navic

local opt = vim.opt

opt.autoindent = true -- maintain indent of current line
opt.breakindent = true -- continue indent visually
opt.breakindentopt = "list:-1"
opt.belloff = "all" -- SILENCE the bell. eternally
opt.backup = false -- don't create backup files
opt.clipboard = "unnamedplus" -- use '+' register for all yanks, and deletes, sync with system clipboard
opt.cmdheight = 1 -- only one line for commands
opt.colorcolumn = "80" -- highlight colorcolumn in line 80 with hl-ColorColumn
opt.completeopt = { "menu", "menuone", "noselect" } -- better autocomplete options
opt.confirm = true -- confirm to save changes before closing modified buffer
opt.cursorline = true -- highlight current line
opt.diffopt = { "vertical", "internal", "filler", "linematch:50" }
opt.expandtab = true -- always use spaces instead of tabs
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 99 -- start unfolded
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep" -- use ripgrep with vimgrep flag
opt.hidden = true -- allows you to hide buffers with unsaved changes without being prompted
opt.ignorecase = true -- case insensitive search. Use \C to enable case sensitive.
opt.inccommand = "nosplit" -- show effects of :s incrementally in buffer
opt.incsearch = true -- do incremental searching
-- opt.joinspaces = true -- don't autoinsert two spaces after '.', '?', '!' for join command
opt.laststatus = 3 -- use global statusline
opt.linebreak = true -- wrap long lines at characters in 'breakat'
-- opt.list = true -- show whitespace
opt.modelines = 5 -- scan this many lines looking for modeline
opt.mouse = "a" -- automatically enable mouse usage
opt.number = true -- show numbers by default
opt.numberwidth = 2 -- minimal number of columns to use for line number column
opt.relativenumber = true -- show relative line numbers by default
opt.ruler = false -- don't show line, column number. status line does this for me
opt.scrolloff = 8 -- start scrolling 3 lines before the edge of the viewport
-- opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- opt.shell = "zsh" -- zsh as default shell
opt.shiftround = true -- always indent by multiple of shiftwidth
opt.shiftwidth = 4 -- spaces per tab (when shifting)
opt.shortmess:append "sI" -- avoid vim intro messages and search messages
opt.showbreak = "↳ " -- downwards arrow with tip rightwards(U+21B3, UTF-8: E2 86 B3)
opt.showcmd = false -- don't show extra info at the end of hte command line
opt.showmode = false -- Statusline does this for me
opt.signcolumn = "number" -- always show sign column. currently there is a visual desync when this is auto. (#14195)
opt.sidescrolloff = 8 -- same as 'scrolloff' but for columns
opt.smartcase = true -- use case sensitive search if capital letter is present
opt.smartindent = true
opt.smarttab = true -- <tab><bs> indent/deindent in leading whitespace
opt.softtabstop = -1 -- use 'shiftwidth' for tab/bs at end of line
opt.spellcapcheck = "" -- don't check for capital letters at teh start of sentences
opt.splitbelow = true -- open horizontal splits below the current one
opt.splitright = true -- open vertical splits right of the current one
opt.switchbuf = "usetab" -- try to reuse windows/tabs when switching buffers
opt.synmaxcol = 200 -- don't bother syntax highlighting long lines
opt.tabstop = 4 -- spaces per tab as editor default
opt.termguicolors = true -- use 24 bit colors in tui
opt.textwidth = 120 -- automatically hard wrap at 120 columns by default
opt.timeoutlen = 300 -- number of ms to wait for a mapped sequence to complete
opt.title = false -- the title of the window to 'titlestring'
opt.ttyfast = true -- let vim know that I am using a fast term
opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block mode
opt.visualbell = false -- stop beeping for non-errors
opt.wildmenu = true -- show options as list when switching buffers etc
opt.undofile = true -- persists undo tree
opt.undolevels = 10000
opt.updatetime = 300
opt.fillchars = {
    horiz = "─",
    horizup = "┴",
    horizdown = "┬",
    vert = "│",
    vertleft = "┤",
    vertright = "├",
    verthoriz = "┼",
}

-- opt.whichwrap:append("<>[]hl")
-- opt.wrap = false -- do not wrap text automatically
opt.writebackup = false -- don't create backup files

opt.formatoptions = opt.formatoptions -- :help fo-table
    - "a" -- dont autoformat
    - "t" -- dont autoformat my code, have linters for that
    + "c" -- auto wrap comments using textwith
    + "q" -- formmating of comments w/ `gq`
    + "l" -- long lines are not broken up
    + "j" -- remove comment leader when joning comments
    + "r" -- continue comment with enter
    - "o" -- but not w/ o and o, dont continue comments
    + "n" -- smart auto indenting inside numbered lists
    - "2" -- this is not grade school anymore

-- opt.listchars = opt.listchars
-- 	+ "nbsp:⦸" -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
-- 	+ "tab:▷┅" -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
-- 	+ "extends:»" -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
-- 	+ "precedes:«" -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
-- 	+ "trail:•" -- BULLET (U+2022, UTF-8: E2 80 A2)

opt.shortmess = opt.shortmess
    + "A" -- ignore annoying swapfile messages
    + "I" -- no spash screen
    -- 	+ "O" -- file-read message overwrites previous
    -- 	+ "T" -- truncate non-file messages in middle
    -- 	+ "W" -- dont echo '[w]/[written]' when writing
    -- 	+ "a" -- use abbreviations in message '[ro]' instead of '[readonly]'
    -- 	-- + "o" -- overwrite file-written mesage
    + "t" -- truncate file messages at start
    + "c" -- dont show matching messages

opt.whichwrap = opt.whichwrap -- crossing line boundaries
    + "b" -- <BS> N & V
    + "s" -- <Space> N & V
    + "h" -- `h` N & V
    + "l" -- `l` N & V
    + "<" -- <Left> N & V
    + ">" -- <Right> N & V
    + "[" -- <Left> I & R
    + "]" -- <Right> I & R

opt.wildmode = { -- shell-like autocomplete to unambiguous portions
    "longest",
    "list",
    "full",
}
