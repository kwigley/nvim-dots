local M = {}
local luasnip = require("luasnip")

function M.setup()
  luasnip.config.set_config({
    history = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
  })

  require("luasnip/loaders/from_vscode").lazy_load()
end

return M
