local api = vim.api

local vi_mode = require("feline.providers.vi_mode")
local git = require("feline.providers.git")
local lsp = require("feline.providers.lsp")
local theme_colors = require("tokyonight.colors").setup()
local gps = require("nvim-gps")

gps.setup()

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
        case = "titlecase",
        filetype_icon = true,
        colored_icon = false,
      },
    },
    left_sep = " ",
    right_sep = "  ",
  },
}
components.active[2] = {
  {
    provider = "position_custom",
    right_sep = " ",
  },
  {
    provider = "git_diff_added",
    -- hl = { fg = "green" },
  },
  {
    provider = "git_diff_changed",
    -- hl = { fg = "orange" },
  },
  {
    provider = "git_diff_removed",
    -- hl = { fg = "red" },
  },
  {
    enabled = function()
      return git.git_info_exists()
    end,
    right_sep = { str = " ", always_visible = true },
  },
  {
    provider = "diagnostic_errors",
    -- hl = { fg = "red" },
  },
  {
    provider = "diagnostic_warnings",
    -- hl = { fg = "yellow" },
  },
  {
    provider = "diagnostic_hints",
    -- hl = { fg = "cyan" },
  },
  {
    provider = "diagnostic_info",
    -- hl = { fg = "skyblue" },
  },
  {
    enabled = function()
      return lsp.diagnostics_exist()
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

require("feline").setup({
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
      local line, col = unpack(api.nvim_win_get_cursor(0))
      col = vim.str_utfindex(api.nvim_get_current_line(), col) + 1

      return string.format("Ln %d, Col %d", line, col)
    end,
  },
})

local winbar_components = {
  active = {
    {
      {
        provider = "file_info",
        opts = {
          type = "unique",
        },
      },
      {
        enabled = function()
          return gps.is_available()
        end,
        provider = function()
          local location = gps.get_location()
          if location ~= "" then
            return " > " .. location
          end
          return ""
        end,
      },
    },
  },
  inactive = {
    {
      {
        provider = "file_info",
        opts = {
          type = "unique",
        },
        hl = {
          fg = theme_colors.dark5,
        },
      },
    },
  },
}

require("feline").winbar.setup({
  components = winbar_components,

  disable = {
    filetypes = {
      "^NvimTree$",
      "^lir$",
    },
  },
})
