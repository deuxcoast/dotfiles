local finders = {}

-------------------------------------
-- Helpers for styling custom pickers
-------------------------------------
--
-- -- Dropdown list theme using a builtin theme definitions :
-- local center_list = require("telescope.themes").get_dropdown {
--     winblend = 10,
--     width = 0.5,
--     prompt = " ",
--     results_height = 15,
--     previewer = false,
-- }
--
-- -- Ivy theme enhancement
-- local with_large_preview = {
--     layout_config = {},
--     winblend = 10,
--     width = 0.5,
--     prompt = " ",
--     results_height = 15,
-- }
--
-- -- Settings for with preview option
-- local with_preview = {
--     winblend = 10,
--     show_line = false,
--     results_title = false,
--     preview_title = false,
--     layout_config = {
--         preview_width = 0.5,
--     },
-- }
--
-- -- Find in neovim config with center theme
-- finders.fd_in_nvim = function()
--     local opts = vim.deepcopy(center_list)
--     opts.prompt_prefix = "nvim >"
--     opts.cwd = vim.fn.stdpath "config"
--     require("telescope.builtin").fd(opts)
-- end
--
-- -- Find files with_preview settings
-- finders.fd = function()
--     local opts = vim.deepcopy(with_preview)
--     opts.prompt_prefix = "FD>"
--     require("telescope.builtin").fd(opts)
-- end
--
-- Fallback to `find_files` if `git_files` can't find a `.git` directory
--
-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}

finders.project_files = function()
    local opts = {} -- define here if you want to define something

    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
        vim.fn.system "git rev-parse --is-inside-work-tree"
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
        require("telescope.builtin").git_files(opts)
    else
        require("telescope.builtin").find_files(opts)
    end
end

return finders
