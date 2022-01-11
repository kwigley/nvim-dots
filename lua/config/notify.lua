local M = {}

function M.setup()
  local notify = require("notify")

  notify.setup()
  vim.notify = notify
end

return M
