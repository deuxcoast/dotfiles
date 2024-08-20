local setup = function()
  require("gitsigns").setup({

    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "" },
      untracked = { text = "▎" },
    },
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local map = DV.map()
      local opts = { buf = bufnr }

      -- Navigation
      map.n("]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end)

      map.n({
        ["<leader>hs"] = gitsigns.stage_hunk,
        ["<leader>hr"] = gitsigns.reset_hunk,
        ["<leader>hS"] = gitsigns.stage_buffer,
        ["<leader>hu"] = gitsigns.undo_stage_hunk,
        ["<leader>hR"] = gitsigns.reset_buffer,
        ["<leader>hp"] = gitsigns.preview_hunk,
        ["<leader>hb"] = function()
          gitsigns.blame_line({ full = true })
        end,
        ["<leader>hd"] = gitsigns.diffthis,
        ["<leader>hD"] = function()
          gitsigns.diffthis("~")
        end,
        ["<leader>td"] = gitsigns.toggle_deleted,
        ["<leader>tb"] = gitsigns.toggle_current_line_blame,
      }, opts)

      map.v({
        ["<leader>hs"] = function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        ["<leader>hr"] = function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
      }, opts)

      map.ox({
        ["ih"] = ":<C-u>Gitsigns select_hunk<CR>",
      })
    end,
  })
end
return setup
