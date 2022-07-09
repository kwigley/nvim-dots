local M = {}

function M.setup()
  require("zen-mode").setup({
    plugins = { gitsigns = true, kitty = { enabled = true, font = "+2" } },
  })
end

return M
