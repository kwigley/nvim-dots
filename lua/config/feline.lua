local tokyonight = require("tokyonight.colors").setup()
local colors = require("feline.defaults").colors

local M = {}

local components = require("feline.presets")["default"].components
local properties = require("feline.presets")["default"].properties

function M.load()
  local overrides = {
    fg = tokyonight.fg,
    bg = tokyonight.bg_statusline,
    black = tokyonight.black,
    cyan = tokyonight.cyan,
    green = tokyonight.green,
    magenta = tokyonight.magenta,
    orange = tokyonight.orange,
    red = tokyonight.red,
    yellow = tokyonight.yellow,
    oceanblue = tokyonight.bg_visual,
    skyblue = tokyonight.bg_search,
    violet = tokyonight.purple,
  }
  for k, v in pairs(overrides) do
    colors[k] = v
  end
  require("feline").setup({
    colors = colors,
    components = components,
    properties = properties,
  })
end

M.load()

return M
