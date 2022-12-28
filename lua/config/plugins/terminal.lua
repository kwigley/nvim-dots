local M = {
  "norcalli/nvim-terminal.lua",
  ft = "terminal",
}

function M.config()
  require("terminal").setup({})
end

return M
