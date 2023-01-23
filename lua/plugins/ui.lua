return {
  {
    "shaunsingh/oxocarbon.nvim",
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      -- style = "storm",
      on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = c.orange }
        -- hl.LineNr = { fg = c.fg_dark }
      end,
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },
  { "folke/twilight.nvim" },
  { "goolord/alpha-nvim", enabled = false },
  {
    "akinsho/nvim-bufferline.lua",
    opts = {
      options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = require("lazyvim.config").icons
      opts.options.section_separators = ""
      opts.options.component_separators = ""
      opts.sections.lualine_c = {
        {
          "filetype",
          separator = "",
          padding = { left = 1, right = 0 },
        },
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
      }
      opts.sections.lualine_z = {}
    end,
  },
  {
    "utilyre/barbecue.nvim",
    version = false,
    event = "BufReadPre",
    opts = {
      show_modified = true,
      attach_navic = false,
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      local scrollbar = require("scrollbar")
      local colors = require("tokyonight.colors").setup()
      scrollbar.setup({
        handle = { color = colors.bg_highlight },
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "noice",
          "notify",
          "neo-tree",
          "lazy",
          "terminal",
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      })
    end,
  },
  {
    "folke/styler.nvim",
    event = "VeryLazy",
    opts = {
      themes = {
        -- markdown = { colorscheme = "tokyonight-storm" },
        help = { colorscheme = "oxocarbon", background = "dark" },
      },
    },
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
