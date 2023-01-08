local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

function M.config()
  require("gitsigns").setup({
    signs = {
      add = {
        hl = "GitSignsAdd",
        text = "▍",
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
      },
      change = {
        hl = "GitSignsChange",
        text = "▍",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = "▸",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = "▾",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = "▍",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      untracked = {
        hl = "GitSignsAdd",
        text = "▍",
        numhl = "GitSignsAddNr",
        linehl = "GitSignsAddLn",
      },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map(
        { "n", "v" },
        "<leader>ghs",
        ":Gitsigns stage_hunk<CR>",
        { desc = "Stage hunk" }
      )
      map(
        { "n", "v" },
        "<leader>ghr",
        ":Gitsigns reset_hunk<CR>",
        { desc = "Reset hunk" }
      )
      map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
      map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>ghb", function()
        gs.blame_line({ full = true })
      end, { desc = "Blame line" })
      map(
        "n",
        "<leader>gtb",
        gs.toggle_current_line_blame,
        { desc = "Toggle current line blame" }
      )
      map("n", "<leader>ghd", gs.diffthis, { desc = "Diff this" })
      map("n", "<leader>ghD", function()
        gs.diffthis("~")
      end, { desc = "Diff this vs parent" })
      map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })

      -- Text object
      map(
        { "o", "x" },
        "ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        { desc = "Select hunk" }
      )
    end,
  })
end

return M
