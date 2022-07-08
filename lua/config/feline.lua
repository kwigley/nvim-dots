local api = vim.api
local fn = vim.fn
local bo = vim.bo

local feline = require("feline")
local vi_mode = require("feline.providers.vi_mode")
local git = require("feline.providers.git")
local theme_colors = require("tokyonight.colors").setup()
local navic = require("nvim-navic")

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
      local line, col = unpack(api.nvim_win_get_cursor(0))
      col = vim.str_utfindex(api.nvim_get_current_line(), col) + 1

      return string.format("Ln %d, Col %d", line, col)
    end,
    relative_file_path_parts = function()
      local filename = api.nvim_buf_get_name(0)
      if filename == "" then
        return " "
      end
      local fileparts = fn.fnamemodify(filename, ":~:.:h")
      if fileparts == "." then
        return " "
      end
      return fn.fnamemodify(fileparts, ":gs?/? ❯ ?") .. " ❯ "
    end,
    file_info_custom = function()
      local readonly_str, modified_str, icon

      local icon_str, icon_color = require("nvim-web-devicons").get_icon_color(
        fn.expand("%:t"),
        nil, -- extension is already computed by nvim-web-devicons
        { default = true }
      )

      icon = { str = icon_str, hl = { fg = icon_color } }

      local filename = api.nvim_buf_get_name(0)
      if filename == "" then
        filename = "[No Name]"
      else
        filename = fn.fnamemodify(filename, ":t")
      end

      if bo.readonly then
        readonly_str = "🔒"
      else
        readonly_str = ""
      end

      -- Add a space at the beginning of the provider if there is an icon
      if icon and icon ~= "" then
        readonly_str = " " .. readonly_str
      end

      if bo.modified then
        modified_str = "●"

        if modified_str ~= "" then
          modified_str = " " .. modified_str
        end
      else
        modified_str = ""
      end

      -- escape any special statusline characters in the filename
      filename = filename:gsub("%%", "%%%%")
      return string.format("%s%s%s", readonly_str, filename, modified_str), icon
    end,
  },
})

local winbar_components = {
  active = {
    {
      { provider = " " },
      {
        provider = "relative_file_path_parts",
        enabled = function()
          return bo.buftype ~= "terminal" and bo.buftype ~= "nofile"
        end,
      },
      {
        provider = "file_info_custom",
      },
      {
        provider = function()
          local location = navic.get_location()
          if location ~= "" then
            return " ❯ " .. location
          end
          return ""
        end,
        enabled = function()
          return navic.is_available()
            and bo.buftype ~= "terminal"
            and bo.buftype ~= "nofile"
        end,
      },
    },
  },
  inactive = {
    {
      {
        provider = "file_info",
        left_sep = " ",
        opts = {
          type = "relative",
        },
        hl = {
          fg = theme_colors.dark5,
        },
      },
    },
  },
}

feline.winbar.setup({
  components = winbar_components,
  disable = {
    filetypes = {
      "^NvimTree$",
      "^lir$",
    },
  },
})
