return {
	"nvim-tree/nvim-tree.lua",
	event = "VimEnter",
	config = function()
		require("nvim-tree").setup({
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				adaptive_size = false,
				side = "left",
				width = 30,
				preserve_window_proportions = true,
			},
			git = {
				enable = true,
				ignore = false,
			},
			filters = {
				custom = { "^\\.git", ".DS_Store" },
				dotfiles = false,
				exclude = { ".gitignore", "github", "github.com" },
			},
			view = {
				adaptive_size = false,
			},
			renderer = {
				highlight_git = true,
				full_name = true,
				icons = {
					webdev_colors = true,
					show = {
						git = true,
					},
				},
			},
		})
	end,
}
