local M = {}

function M.setup()
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
