local M = {}

function M.setup()
  require("git-conflict").setup({
    disable_diagnostics = true,
  })
end

return M
