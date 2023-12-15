return {
  {
    "ruifm/gitlinker.nvim",
    keys = {
      {
        "<leader>gy",
        '<cmd>lua require"gitlinker".get_repo_url()<cr>',
        mode = { "n", "v" },
        desc = "Open in GitHub",
      },
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
    event = "VimEnter",
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },
    opts = {
      disable_diagnostics = true,
    },
    keys = {
      {
        "<leader>gx",
        "<Cmd>GitConflictListQf<CR>",
        desc = "List Git Conflicts",
      },
    },
  },
}
