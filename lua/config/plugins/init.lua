return {
  "b0o/SchemaStore.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "MunifTanjim/nui.nvim",
  "williamboman/mason-lspconfig.nvim",
  "nvim-lua/plenary.nvim",
  "windwp/nvim-spectre",
  "folke/twilight.nvim",
  "folke/which-key.nvim",

  { "shaunsingh/oxocarbon.nvim", enabled = true },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    config = true,
  },
  {
    "Asheq/close-buffers.vim",
    cmd = { "Bdelete" },
  },
  { "ellisonleao/glow.nvim", cmd = { "Glow" } },
}
