local util = require("util")

require("config.lsp.diagnostics")

local function on_attach(client, bufnr)
  require("config.lsp.formatting").setup(client, bufnr)
  require("config.lsp.keys").setup(client, bufnr)
  require("config.lsp.highlighting").setup(client)
  -- TypeScript specific stuff
  if client.name == "typescript" or client.name == "tsserver" then
    require("config.lsp.ts-utils").setup(client)
  end
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

-- TODO move this to a util package
local servers = {
  pyright = {},
  bashls = {},
  dockerls = {},
  tsserver = {},
  svelte = {},
  cssls = {},
  jsonls = {
    init_options = {
      provideFormatter = false, -- using prettier to format json
    },
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  html = {},
  tailwindcss = {
    root_dir = require("lspconfig/util").root_pattern(
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.ts",
      "postcss.config.js",
      "postcss.config.ts",
      "package.json",
      "node_modules",
      ".git"
    ),
  },
  clangd = {},
  gopls = {},
  sumneko_lua = require("lua-dev").setup({}),
  vimls = {},
  terraformls = {},
  prismals = {},
  taplo = { cmd = { "taplo-lsp", "run" } },
  yamlls = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local server_opts = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

local rust_analyzer_settings = {
  settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

require("rust-tools").setup({
  server = vim.tbl_deep_extend("force", server_opts, rust_analyzer_settings),
})

local lspconfig = require("lspconfig")
for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend("force", server_opts, config))
  local cfg = lspconfig[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    util.error(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
  end
end

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
    nls.builtins.completion.spell.with({
      filetypes = {
        "markdown",
        "markdown.mdx",
      },
    }),
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.diagnostics.flake8,
    nls.builtins.diagnostics.golangci_lint,
  },
  on_attach = on_attach,
})
local signature_config = {
  hint_enable = false,
  max_width = 80,
}
require("lsp_signature").setup(signature_config)
