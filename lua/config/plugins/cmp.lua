local M = {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "f3fora/cmp-spell",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-path",
    {
      "zbirenbaum/copilot-cmp",
      config = true,
    },
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-buffer",
    "onsails/lspkind.nvim",
  },
}

function M.config()
  vim.o.completeopt = "menuone,noselect"

  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  cmp.setup({
    completion = {
      completeopt = "menu,menuone,noinsert",
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = cmp.mapping.confirm({
        -- this is the important line
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
      ["<C-Space>"] = cmp.mapping.complete({}),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    }),
    sources = cmp.config.sources({
      { name = "copilot" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "spell" },
      { name = "path" },
      { name = "crates" },
      { name = "calc" },
      { name = "emoji" },
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol", -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        symbol_map = { Copilot = "" },
      }),
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        require("copilot_cmp.comparators").prioritize,
        require("copilot_cmp.comparators").score,

        -- Below is the default comparitor list and order for nvim-cmp
        cmp.config.compare.offset,
        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
    formatters = {
      insert_text = require("copilot_cmp.format").remove_existing,
    },
  })
end

return M
