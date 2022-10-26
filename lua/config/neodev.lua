local M = {}
local neodev = require("neodev")

function M.setup()
  neodev.setup({
    library = {
      enabled = true,
      runtime = true,
      types = true,
      plugins = true,
    },
    setup_jsonls = true,
  })
end

return M
