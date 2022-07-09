local M = {}

function M.setup()
  require("neogit").setup({
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = {
      diffview = true,
    },
  })
end

return M
