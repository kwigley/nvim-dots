local M = {}

function M.setup()
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    callback = function()
      require("nvim-lightbulb").update_lightbulb()
    end,
  })
end

return M
