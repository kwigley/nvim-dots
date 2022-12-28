local M = {
  "nvim-tree/nvim-web-devicons",
}

function M.config()
  require("nvim-web-devicons").setup({
    override = {
      lir_folder_icon = {
        icon = "",
        color = "#7ebae4",
        name = "LirFolderNode",
      },
    },
    default = true,
  })
end

return M
