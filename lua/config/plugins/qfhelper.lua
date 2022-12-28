local M = {
  "stevearc/qf_helper.nvim",
}

function M.config()
  require("qf_helper").setup()
end

return M
