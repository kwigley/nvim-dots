return {
  { "shaunsingh/oxocarbon.nvim" },
  {
    "folke/tokyonight.nvim",
    opts = {
      -- style = "storm",
      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = c.orange }
        hl.LineNr = { fg = c.fg_dark }
      end,
    },
  },
}
