local M = {}

function M.setup()
  require("noice").setup({})
  require("telescope").load_extension("noice")
end

return M
