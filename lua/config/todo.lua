local M = {}
function M.setup()
  require("todo-comments").setup({
    keywords = { TODO = { alt = { "WIP" } } },
    highlight = { exclude = { "toggleterm" } },
  })
end

return M
