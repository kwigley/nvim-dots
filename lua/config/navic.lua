local M = {}

function M.setup()
  require("nvim-navic").setup({ separator = " ❯ " })
end

return M
