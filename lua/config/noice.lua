local M = {}

function M.setup()
  require("noice").setup({
    presets = { inc_rename = true },
  })
  require("telescope").load_extension("noice")
end

return M
