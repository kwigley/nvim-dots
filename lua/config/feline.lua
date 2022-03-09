local vi_mode_utils = require("feline.providers.vi_mode")
local theme_colors = require("tokyonight.colors").setup()

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
      fg = "skyblue",
    },
  },
  {
    provider = "vi_mode",
    hl = function()
      return {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = vi_mode_utils.get_mode_color(),
        style = "bold",
      }
    end,
    right_sep = " ",
    icon = "",
  },
  {
    provider = {
      name = "file_info",
      opts = {
        type = "unique",
      },
    },
    hl = {
      fg = "white",
      bg = "oceanblue",
      style = "bold",
    },
    left_sep = {
      "slant_left_2",
      { str = " ", hl = { bg = "oceanblue", fg = "NONE" } },
    },
    right_sep = {
      { str = " ", hl = { bg = "oceanblue", fg = "NONE" } },
      "slant_right_2",
      " ",
    },
  },
  {
    provider = "position",
    left_sep = " ",
    right_sep = {
      "  ",
    },
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
    provider = "git_diff_added",
    hl = {
      fg = "green",
    },
  },
  {
    provider = "git_diff_changed",
    hl = {
      fg = "orange",
    },
  },
  {
    provider = "git_diff_removed",
    hl = {
      fg = "red",
    },
  },
  {
    provider = "scroll_bar",

    left_sep = "  ",
    hl = {
      fg = "skyblue",
      style = "bold",
    },
  },
}

components.inactive[1] = {
  {
    provider = {
      name = "file_info",
      opts = {
        type = "relative",
      },
    },
    hl = {
      fg = "white",
      bg = "oceanblue",
      style = "bold",
    },
    left_sep = {
      str = " ",
      hl = { bg = "oceanblue", fg = "NONE" },
    },
    right_sep = {
      { str = " ", hl = { bg = "oceanblue", fg = "NONE" } },
      "slant_right_2",
      " ",
    },
  },
}

components.inactive[2] = {
  {
    provider = "file_type",
    hl = {
      fg = "white",
      bg = "oceanblue",
      style = "bold",
    },
    left_sep = {
      str = " ",
      hl = {
        fg = "NONE",
        bg = "oceanblue",
      },
    },
    right_sep = {
      {
        str = " ",
        hl = {
          fg = "NONE",
          bg = "oceanblue",
        },
      },
      " ",
    },
  },
  -- Empty component to fix the highlight till the end of the statusline
  -- {},
}

require("feline").setup({
  components = components,
  vi_mode_colors = vi_mode_colors,
  theme = colors,
})
