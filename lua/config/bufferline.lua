local M = {}

function M.setup()
  require("bufferline").setup({
    options = {
      offsets = { { filetype = "NvimTree" } },
      diagnostics = "nvim_lsp",
    },
  })
end

return M
