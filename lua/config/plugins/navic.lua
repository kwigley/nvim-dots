local M = {
  "SmiteshP/nvim-navic",
}

function M.setup()
  require("nvim-navic").setup({ separator = " ❯ " })
end

return M
