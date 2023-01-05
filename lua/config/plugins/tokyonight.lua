local M = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 999,
}

function M.config()
  local tokyonight = require("tokyonight")
  tokyonight.setup({
    style = "moon",
    sidebars = {
      "qf",
      "vista_kind",
      "terminal",
      "spectre_panel",
      "startuptime",
      "Outline",
    },
    transparent = false,
    styles = {},
    on_colors = function(c) end,
    on_highlights = function(hl, c)
      -- make the current line cursor orange
      hl.CursorLineNr = { fg = c.orange, bold = true }
    end,
  })

  tokyonight.load()
end

return M
