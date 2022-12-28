local M = {
  "jose-elias-alvarez/null-ls.nvim",
}

function M.setup(options)
  local nls = require("null-ls")
  nls.setup({
    save_after_format = false,
    sources = {
      nls.builtins.formatting.prettier.with({
        filetypes = {
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
          "markdown.mdx",
          "graphql",
        },
      }),
      nls.builtins.formatting.stylua,
      nls.builtins.formatting.fish_indent,
      -- nls.builtins.formatting.reorder_python_imports,
      -- nls.builtins.formatting.autopep8,
      nls.builtins.completion.spell.with({
        filetypes = {
          "markdown",
          "markdown.mdx",
        },
      }),
      nls.builtins.diagnostics.selene.with({
        condition = function(utils)
          return utils.root_has_file({ "selene.toml" })
        end,
      }),
      nls.builtins.diagnostics.shellcheck,
      nls.builtins.diagnostics.flake8,
      nls.builtins.diagnostics.golangci_lint,
    },
    on_attach = options.on_attach,
    root_dir = require("null-ls.utils").root_pattern(
      ".null-ls-root",
      ".neoconf.json",
      ".git"
    ),
  })
end

function M.has_formatter(ft)
  local sources = require("null-ls.sources")
  local available = sources.get_available(ft, "NULL_LS_FORMATTING")
  return #available > 0
end

return M
