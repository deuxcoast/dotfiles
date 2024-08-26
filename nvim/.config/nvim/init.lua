-- Fallback for vims with no env access like Veonim
-- used by plugin/*
vim.g.mapleader = " "

-- Must be 0 and not false
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0 -- disable python 2
vim.g.loaded_python3_provider = 0 -- disable python 3 also, who's still using these?

require("deux.options")
require("deux.behaviors")
require("deux.mappings")

require("deux.lazy")
require("deux.signs")
