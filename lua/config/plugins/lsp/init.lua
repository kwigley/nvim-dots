local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
    { "folke/neodev.nvim", config = true },
  },
  pin = true,
}

function M.config()
  require("mason")
  require("config.plugins.lsp.diagnostics").setup()

  local function on_attach(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end
    require("config.plugins.lsp.formatting").setup(client, bufnr)
    require("config.plugins.lsp.keys").setup(client, bufnr)
  end

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
    sumneko_lua = {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    },
    vimls = {},
    terraformls = {},
    prismals = {},
    taplo = {},
    yamlls = {},
    csharp_ls = {
      cmd = { "/Users/kwigley/.dotnet/tools/csharp-ls" },
    },
    zls = {
      cmd = { "/Users/kwigley/workspace/zls/zig-out/bin/zls" },
    },
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities()

  local options = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  for server, opts in pairs(servers) do
    opts = vim.tbl_deep_extend("force", {}, options, opts or {})
    if server == "tsserver" then
      require("typescript").setup({ server = opts })
    else
      require("lspconfig")[server].setup(opts)
    end
  end

  require("config.plugins.null-ls").setup(options)
  require("config.plugins.rust-tools").setup(options)
end

return M
