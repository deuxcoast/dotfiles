-- if not pcall(require, "luasnip") then
--     return
-- end
-- local ls = require "luasnip"
-- ls.config.set_config {
--     -- This tells LuaSnip to remember to keep around the last snippet.
--     -- You can jump back into it even if you move outside of the selection
--     history = false,
--
--     -- This one is cool cause if you have dynamic snippets, it updates as you type!
--     updateevents = "TextChanged,TextChangedI",
--
--     -- Autosnippets:
--     enable_autosnippets = true,
-- }
--
-- require "duex.snips"
-- require("luasnip/loaders/from_vscode").load { paths = { "~/.local/share/nvim/lazy/friendly-snippets" } }
--
-- local M = {}
--
-- function M.expand_or_jump()
--     if ls.expand_or_jumpable() then
--         ls.expand_or_jump()
--     end
-- end
--
-- function M.jump_next()
--     if ls.jumpable(1) then
--         ls.jump(1)
--     end
-- end
--
-- function M.jump_prev()
--     if ls.jumpable(-1) then
--         ls.jump(-1)
--     end
-- end
--
-- function M.change_choice()
--     if ls.choice_active() then
--         ls.change_choice(1)
--     end
-- end
--
-- function M.reload_package(package_name)
--     for module_name, _ in pairs(package.loaded) do
--         if string.find(module_name, "^" .. package_name) then
--             package.loaded[module_name] = nil
--             require(module_name)
--         end
--     end
-- end
--
-- function M.refresh_snippets()
--     ls.cleanup()
--     M.reload_package "duex.snips"
-- end
--
-- local set = vim.keymap.set
--
-- local mode = { "i", "s" }
-- local normal = { "n" }
--
-- set(mode, "<M-n>", M.expand_or_jump)
-- set(mode, "<M-p>", M.jump_prev)
-- set(mode, "<C-e>", M.change_choice)
-- set(normal, ",r", M.refresh_snippets)
