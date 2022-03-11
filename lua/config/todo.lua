require("todo-comments").setup({
  keywords = { TODO = { alt = { "WIP" } } },
  highlight = { exclude = { "toggleterm" } },
  pattern = [[\b(KEYWORDS):]],
  -- pattern = [[\b(KEYWORDS)]],
})
