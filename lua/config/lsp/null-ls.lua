local nls = require("null-ls")

local M = {}

function M.setup()
  nls.config({
    debounce = 150,
    debug = true,
    save_after_format = false,
    sources = {
      nls.builtins.formatting.prettier.with({
        filetypes = { "css", "html", "json", "yaml", "markdown" },
      }),
      nls.builtins.formatting.prettier_d_slim,
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
