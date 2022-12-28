local M = {
  "ruifm/gitlinker.nvim",
  keys = {
    {
      "<leader>gy",
      '<cmd>lua require"gitlinker".get_repo_url()<cr>',
      desc = "Open in GitHub",
    },
  },
}

function M.config()
  require("gitlinker").setup({
    opts = {
      action_callback = require("gitlinker.actions").open_in_browser,
      print_url = false,
    },
  })
end

return M
