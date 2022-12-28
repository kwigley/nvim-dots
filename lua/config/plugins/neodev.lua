local M = {
  "folke/neodev.nvim",
}

function M.config()
  require("neodev").setup({
    library = {
      enabled = true,
      runtime = true,
      types = true,
      plugins = true,
    },
    setup_jsonls = true,
  })
end

return M
