return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      autotag = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = "<C-s>",
          node_decremental = "<C-r>",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User LazyFile",
    enabled = true,
    opts = { mode = "cursor" },
  },
}
