local M = {}

function M.setup()
  require("trouble").setup({
    auto_open = false,
    mode = "document_diagnostics",
  })
end

return M
