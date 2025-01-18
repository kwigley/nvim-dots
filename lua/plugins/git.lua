return {
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
    config = function()
      require("gitlinker").setup({
        opts = {
          action_callback = require("gitlinker.actions").open_in_browser,
          print_url = false,
        },
      })
    end,
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
