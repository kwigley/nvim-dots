local cmp = require("cmp")
local luasnip = require("luasnip")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match("%s")
      == nil
end

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "spell" },
    { name = "path" },
    { name = "crates" },
    { name = "calc" },
    { name = "emoji" },
  },
  experimental = {
    ghost_text = {
      hl_group = "LspCodeLens",
    },
  },
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
)
