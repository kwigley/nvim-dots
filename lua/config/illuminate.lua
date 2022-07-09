local M = {}

function M.setup()
  vim.g.Illuminate_delay = 1000
  vim.g.Illuminate_ftblacklist = { "lir", "nvimtree" }
end

return M
