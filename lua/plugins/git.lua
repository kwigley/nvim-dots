return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gy",
        function()
          Snacks.gitbrowse({
            open = function(url)
              vim.fn.setreg("+", url)
              vim.notify("Git link yanked: " .. url)
            end,
            notify = false,
          })
        end,
        mode = { "n", "v" },
        desc = "Yank git link",
      },
      {
        "<leader>gY",
        function()
          Snacks.gitbrowse()
        end,
        mode = { "n", "v" },
        desc = "Open git link",
      },
    },
  },
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    config = function()
      -- GitConflictChooseOurs -- Select the current changes.
      -- GitConflictChooseTheirs -- Select the incoming changes.
      -- GitConflictChooseBoth -- Select both changes.
      -- GitConflictChooseNone -- Select both none of the changes.
      -- GitConflictNextConflict -- Move to the next conflict.
      -- GitConflictPrevConflict -- Move to the previous conflict.
      -- GitConflictListQf -- Get all conflict to quickfix

      require("git-conflict").setup({
        default_mappings = false, -- disable buffer local mapping created by this plugin
        disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
      })

      vim.keymap.set(
        "n",
        "<leader>go",
        "<Plug>(git-conflict-ours)",
        { desc = "Conflict - Choose Ours" }
      )
      vim.keymap.set(
        "n",
        "<leader>gt",
        "<Plug>(git-conflict-theirs)",
        { desc = "Conflict - Choose Theirs" }
      )
      vim.keymap.set(
        "n",
        "<leader>gb",
        "<Plug>(git-conflict-both)",
        { desc = "Conflict - Choose Both" }
      )
      vim.keymap.set(
        "n",
        "<leader>g0",
        "<Plug>(git-conflict-none)",
        { desc = "Conflict - Choose None" }
      )
      vim.keymap.set(
        "n",
        "<leader>gq",
        "<cmd>GitConflictListQf<cr>",
        { desc = "Conflict - Quicklist" }
      )
      vim.keymap.set(
        "n",
        "<leader>gn",
        "<Plug>(git-conflict-next-conflict)",
        { desc = "Conflict - Goto Next" }
      )
      vim.keymap.set(
        "n",
        "<leader>gp",
        "<Plug>(git-conflict-prev-conflict)",
        { desc = "Conflict - Goto Previous" }
      )
    end,
  },
}
