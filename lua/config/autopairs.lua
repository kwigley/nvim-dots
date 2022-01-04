local npairs = require("nvim-autopairs")

npairs.setup({
  disable_filetype = { "TelescopePrompt", "vim", "spectre_panel" },
  fast_wrap = {},
  enable_check_bracket_line = false,
})
