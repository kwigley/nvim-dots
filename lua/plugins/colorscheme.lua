return {
  { "shaunsingh/oxocarbon.nvim" },
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = c.orange, bold = true }
      end,
    },
  },
}
