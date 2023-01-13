return {
  {
    "ruifm/gitlinker.nvim",
    keys = {
      {
        "<leader>gy",
        '<cmd>lua require"gitlinker".get_repo_url()<cr>',
        mode = { "n", "v" },
        desc = "Open in GitHub",
      },
    },
    config = function()
      require("gitlinker").setup({
        opts = {
          action_callback = require("gitlinker.actions").open_in_browser,
          print_url = false,
        },
      })
    end,
  },
  { "norcalli/nvim-terminal.lua", ft = "terminal", config = true },
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    opts = {
      open_mapping = [[<c-\>]],
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    config = true,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" } },
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*", "!lazy" },
      buftype = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = "background", -- Set the display mode.
        virtualtext = "■",
      },
    },
  },
}
