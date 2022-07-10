local M = {}

function M.setup()
  require("auto-session").setup({
    log_level = "info",
    auto_session_suppress_dirs = { "~/", "~/workspace" },
  })
end

return M
