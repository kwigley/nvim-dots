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
        case = "titlecase",
        filetype_icon = true,
        colored_icon = false,
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
      return " " .. fn.fnamemodify(fileparts, ":gs?/? > ?") .. " > "
    end,
    file_info_custom = function(component, opts)
      local readonly_str, modified_str, icon

      -- Avoid loading nvim-web-devicons if an icon is provided already
      if not component.icon then
        local icon_str, icon_color =
          require("nvim-web-devicons").get_icon_color(
            fn.expand("%:t"),
            nil, -- extension is already computed by nvim-web-devicons
            { default = true }
          )

        icon = { str = icon_str }

        if opts.colored_icon == nil or opts.colored_icon then
          icon.hl = { fg = icon_color }
        end
      end

      local filename = api.nvim_buf_get_name(0)
      local type = opts.type or "base-only"
      if filename == "" then
        filename = "[No Name]"
      elseif type == "short-path" then
        filename = fn.pathshorten(filename)
      elseif type == "base-only" then
        filename = fn.fnamemodify(filename, ":t")
      elseif type == "relative" then
        filename = fn.fnamemodify(filename, ":~:.")
      elseif type == "relative-short" then
        filename = fn.pathshorten(fn.fnamemodify(filename, ":~:."))
      elseif type ~= "full-path" then
        filename = fn.fnamemodify(filename, ":t")
      end

      if opts.show_readonly_icon and bo.readonly then
        readonly_str = opts.file_readonly_icon or "🔒"
      else
        readonly_str = ""
      end

      -- Add a space at the beginning of the provider if there is an icon
      if (icon and icon ~= "") or (component.icon and component.icon ~= "") then
        readonly_str = " " .. readonly_str
      end

      if opts.show_modified_icon and bo.modified then
        modified_str = opts.file_modified_icon or "●"

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
      {
        provider = "relative_file_path_parts",
      },
      {
        provider = "file_info_custom",
        opts = {
          type = "base-only",
          colored_icon = false,
          show_modified_icon = false,
        },
      },
      {
        enabled = function()
          return navic.is_available()
        end,
        provider = function()
          local location = navic.get_location()
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
        left_sep = " ",
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

feline.winbar.setup({
  components = winbar_components,
  disable = {
    filetypes = {
      "^NvimTree$",
      "^lir$",
    },
  },
})
