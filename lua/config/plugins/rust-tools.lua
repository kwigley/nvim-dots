local M = {
  "simrat39/rust-tools.nvim",
}

function M.setup(options)
  local rust_analyzer_settings = {
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        inlayHints = { locationLinks = false },
        cargo = {
          autoReload = true,
        },
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  }

  require("rust-tools").setup({
    server = vim.tbl_deep_extend("force", options, rust_analyzer_settings),
  })
end

return M
