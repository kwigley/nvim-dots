return {
  { "norcalli/nvim-terminal.lua", ft = "terminal", config = true },
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = {
      open_mapping = [[<c-\>]],
    },
  },
}