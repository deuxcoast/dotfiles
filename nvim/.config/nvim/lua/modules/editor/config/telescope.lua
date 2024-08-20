local setup = function()
  local telescope = require("telescope")
  local telescope_config = require("telescope.config")

  -- Clone the default Telescope configuration
  local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

  -- I want to search in hidden/dot files.
  table.insert(vimgrep_arguments, "--hidden")
  -- I don't want to search in the `.git` directory.
  table.insert(vimgrep_arguments, "--glob")
  table.insert(vimgrep_arguments, "!**/.git/*")

  local trouble_present, _ = pcall(require, "trouble.providers.telescope")
  if not trouble_present then
    print("trouble is not installed")
  end

  telescope.setup({
    defaults = {
      -- `hidden = true` is not supported in text grep commands.
      vimgrep_arguments = vimgrep_arguments,
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.90,
        height = 0.85,
        prompt_position = "bottom",
        horizontal = {
          preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },
        vertical = {
          width = 0.9,
          height = 0.95,
          preview_height = 0.5,
        },

        flex = {
          horizontal = {
            preview_width = 0.9,
          },
        },
      },
      selection_strategy = "reset",
      sorting_strategy = "descending",
      scroll_strategy = "cycle",
      color_devicons = true,
    },
    mappings = {
      n = {
        ["<C-c>"] = require("telescope.actions").close,
        ["<C-t>"] = require("trouble.sources.telescope").open,
      },
      i = { ["<C-t>"] = require("trouble.sources.telescope").open },
    },
    pickers = {
      find_files = {
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      },
      colorscheme = {
        ignore_builtins = true,
        enable_preview = true,
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("nvim_config")
  telescope.load_extension("file_browser")

  local map = DV.map()
  local cmd = map.cmd

  local finder = require("modules.editor.config.telescope_finders")

  map.n({
    ["<leader><leader>"] = cmd("Telescope find_files"),
    ["<leader>ff"] = finder.project_files,
    ["<leader>fs"] = cmd("Telescope live_grep"),
    ["<leader>fm"] = cmd("Telescope noice"),
    ["<leader>fb"] = cmd("Telescope buffers"),
    ["<leader>ft"] = cmd("Telescope colorscheme"),
    ["<leader>fg"] = cmd("Telescope git_bcommit"),
    ["<leader>fG"] = cmd("Telescope git_commit"),
    ["<leader>fn"] = cmd("Telescope nvim_config"),
    ["<leader>fa"] = cmd("Telescope file_browser path=%:p:h select_buffer=true"),
  })
end

return setup
