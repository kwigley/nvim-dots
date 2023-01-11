return {
  { "goolord/alpha-nvim", enabled = false },
  { "akinsho/nvim-bufferline.lua", enabled = false },
  { "nvim-lualine/lualine.nvim", enabled = false },
  {
    "feline-nvim/feline.nvim",
    version = nil,
    event = "VeryLazy",
    config = function()
      local feline = require("feline")
      local vi_mode = require("feline.providers.vi_mode")
      local git = require("feline.providers.git")
      local theme_colors = require("tokyonight.colors").setup({ transform = true })

      local colors = {
        bg = theme_colors.bg_dark,
        fg = theme_colors.fg_dark,
        yellow = theme_colors.yellow,
        cyan = theme_colors.cyan,
        darkblue = theme_colors.blue7,
        green = theme_colors.green,
        orange = theme_colors.orange,
        violet = theme_colors.purple,
        magenta = theme_colors.magenta,
        blue = theme_colors.blue,
        red = theme_colors.red,
      }

      local vi_mode_colors = {
        NORMAL = colors.green,
        INSERT = colors.blue,
        VISUAL = colors.violet,
        OP = colors.green,
        BLOCK = colors.blue,
        REPLACE = colors.red,
        ["V-REPLACE"] = colors.red,
        ENTER = colors.cyan,
        MORE = colors.cyan,
        SELECT = colors.orange,
        COMMAND = colors.magenta,
        SHELL = colors.green,
        TERM = colors.blue,
        NONE = colors.yellow,
      }

      local components = {
        active = {},
        inactive = {},
      }

      components.active[1] = {
        {
          provider = "▊ ",
          hl = {
            fg = "blue",
          },
        },
        {
          provider = "vi_mode",
          hl = function()
            return {
              name = vi_mode.get_mode_highlight_name(),
              fg = vi_mode.get_mode_color(),
              style = "bold",
            }
          end,
          right_sep = " ",
          icon = "",
        },
        {
          provider = "git_branch",
          left_sep = " ",
          right_sep = " ",
        },
        {
          enabled = function()
            return vim.bo.filetype ~= ""
          end,
          provider = {
            name = "file_type",
            opts = {
              filetype_icon = true,
              colored_icon = true,
            },
          },
          left_sep = " ",
          right_sep = " ",
        },
        {
          provider = "diagnostic_errors",
          hl = { fg = "red" },
        },
        {
          provider = "diagnostic_warnings",
          hl = { fg = "yellow" },
        },
        {
          provider = "diagnostic_hints",
          hl = { fg = "cyan" },
        },
        {
          provider = "diagnostic_info",
          hl = { fg = "skyblue" },
        },
      }
      components.active[2] = {
        {
          provider = "position_custom",
          right_sep = " ",
        },
        {
          provider = "git_diff_added",
          hl = { fg = "green" },
        },
        {
          provider = "git_diff_changed",
          hl = { fg = "orange" },
        },
        {
          provider = "git_diff_removed",
          hl = { fg = "red" },
        },
        {
          enabled = function()
            return git.git_info_exists()
          end,
          right_sep = { str = " ", always_visible = true },
        },
        {
          provider = "scroll_bar",
          hl = {
            fg = "skyblue",
            style = "bold",
          },
        },
      }

      feline.setup({
        components = components,
        vi_mode_colors = vi_mode_colors,
        theme = colors,
        force_inactive = {
          filetypes = {
            "^NvimTree$",
            "^packer$",
            "^startify$",
            "^fugitive$",
            "^fugitiveblame$",
            "^qf$",
            "^help$",
            "^TelescopePrompt$",
          },
          buftypes = {
            "^terminal$",
            "^nofile$",
          },
        },
        custom_providers = {
          position_custom = function()
            local position = vim.api.nvim_win_get_cursor(0)
            local line, col = position[1], position[2]
            col = vim.str_utfindex(vim.api.nvim_get_current_line(), col) + 1

            return string.format("Ln %d, Col %d", line, col)
          end,
        },
      })
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
        excluded_filetypes = { "prompt", "TelescopePrompt", "noice", "notify" },
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
        markdown = { colorscheme = "tokyonight-storm" },
        help = { colorscheme = "oxocarbon", background = "dark" },
      },
    },
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    config = function()
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set("", key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")

      animate.setup({
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      })
    end,
  },
}
