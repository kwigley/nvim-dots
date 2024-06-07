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
    opts = {
      disable_diagnostics = true,
      default_mappings = false,
    },
    keys = {
      { "<leader>go", ":GitConflictChooseOurs<cr>", desc = "Choose Ours" },
      { "<leader>gt", ":GitConflictChooseTheirs<cr>", desc = "Choose Theirs" },
      { "<leader>gb", ":GitConflictChooseBoth<cr>", desc = "Choose Both" },
      { "<leader>g0", ":GitConflictChooseNone<cr>", desc = "Choose None" },
      { "]x", ":GitConflictNextConflict<cr>", desc = "Next Conflict" },
      { "[x", ":GitConflictPrevConflict<cr>", desc = "Prev Conflict" },
      {
        "<leader>gx",
        "<Cmd>GitConflictListQf<CR>",
        desc = "List Git Conflicts",
      },
    },
  },
}
