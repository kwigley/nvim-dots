local M = {}
local npairs = require("nvim-autopairs")

function M.setup()
  npairs.setup({
    disable_filetype = { "TelescopePrompt", "vim", "spectre_panel" },
    fast_wrap = {},
    enable_check_bracket_line = false, -- I don't like this behavior
    check_ts = true,
  })
end

return M
