local M = {
  "saecki/crates.nvim",
  ft = "toml",
}

function M.config()
  require("crates").setup()
end

return M
