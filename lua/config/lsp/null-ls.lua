local nls = require("null-ls")

local M = {}

function M.setup()
  nls.config({
    debounce = 150,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.prettier.with({
        filetypes = {
          "svelte",
        },
      }),
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
  return require("null-ls.generators").can_run(ft, "NULL_LS_FORMATTING")
end

return M
