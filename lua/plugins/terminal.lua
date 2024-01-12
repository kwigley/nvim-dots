return {
  { "norcalli/nvim-terminal.lua", ft = "terminal", config = true },
  {
    "willothy/flatten.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    version = "*", -- latest stable version, may have breaking changes if major version changed
    config = function()
      require("kitty-scrollback").setup()
    end,
  },
  -- { "mrjones2014/smart-splits.nvim", build = "./kitty/install-kittens.bash" },
}
