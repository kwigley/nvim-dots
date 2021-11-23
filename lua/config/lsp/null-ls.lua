local nls = require("null-ls")

local M = {}

function M.setup()
  nls.config({
    debounce = 150,
    -- debug = true,
    -- save_after_format = false,
    sources = {
      nls.builtins.formatting.prettier_d_slim.with({
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
        "markdown",
        "graphql",
      }),
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.fish_indent,
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.flake8,
    },
  })
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
