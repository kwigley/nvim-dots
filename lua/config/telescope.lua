local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

local M = {}

function M.setup()
  telescope.setup({
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
    defaults = {
      layout_strategy = "vertical",
      mappings = {
        i = { ["<c-t>"] = trouble.open_with_trouble },
        n = { ["<c-t>"] = trouble.open_with_trouble },
      },
      prompt_prefix = "❯ ",
      selection_caret = " ",
      winblend = 5,
    },
  })

  require("telescope").load_extension("fzf")
  telescope.load_extension("gh")

  local util = require("util")

  util.nnoremap("<Leader><Space>", "<cmd>Telescope find_files<cr>")
  util.nnoremap("<Leader>fd", function()
    require("telescope.builtin").git_files({
      cwd = "~/.config/nvim",
    })
  end)
end

return M
