return {
  -- "tokyonight" picks the variant from 'background', which Neovim syncs with the
  -- terminal, so the editor follows Rex between Tokyonight Night and Day.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      light_style = "day",
    },
  },
}
