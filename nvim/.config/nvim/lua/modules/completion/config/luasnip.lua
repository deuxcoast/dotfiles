local setup = function()
	local ls = require("luasnip")
	require("snippets")
	require("luasnip/loaders/from_vscode").load({ paths = { "~/.local/share/nvim2/lazy/friendly-snippets" } })

	local M = {}

	function M.expand_or_jump()
		if ls.expand_or_jumpable() then
			ls.expand_or_jump()
		end
	end

	function M.jump_next()
		if ls.jumpable(1) then
			ls.jump(1)
		end
	end

	function M.jump_prev()
		if ls.jumpable(-1) then
			ls.jump(-1)
		end
	end

	function M.change_choice()
		if ls.choice_active() then
			ls.change_choice(1)
		end
	end

	function M.reload_package(package_name)
		for module_name, _ in pairs(package.loaded) do
			if string.find(module_name, "^" .. package_name) then
				package.loaded[module_name] = nil
				require(module_name)
			end
		end
	end

	function M.refresh_snippets()
		ls.cleanup()
		M.reload_package("config.snippets.snips")
	end

	local map = DV.map()
	map.is("<M-n>", function()
		M.expand_or_jump()
	end)
	map.is("<M-p>", function()
		M.jump_prev()
	end)
	map.is("<C-e>", function()
		M.change_choice()
	end)
	map.n(",r", function()
		M.refresh_snippets()
	end)
end

return setup
