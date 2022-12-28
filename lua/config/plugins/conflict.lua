local M = {
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
}

function M.config()
  require("git-conflict").setup({
    disable_diagnostics = true,
  })
end

return M
