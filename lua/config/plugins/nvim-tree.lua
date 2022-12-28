local M = {
  "nvim-tree/nvim-tree.lua",
  cmd = {
    "NvimTreeFindFileToggle",
  },
}

function M.config()
  require("nvim-tree").setup({
    hijack_netrw = false,
    view = {
      side = "right",
    },
  })
end

return M
