local M = {
  "folke/persistence.nvim",
  event = "BufReadPre",
  config = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
}

return M
