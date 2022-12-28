local M = {
  "abecodes/tabout.nvim",
  event = "VeryLazy",
}

function M.config()
  require("tabout").setup({})
end

return M
