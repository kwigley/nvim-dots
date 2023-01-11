return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-github.nvim" },
      { "debugloop/telescope-undo.nvim" },
      { "johmsalas/text-case.nvim", config = true },
    },
    keys = {
      {
        "<leader>sw",
        "<cmd>Telescope grep_string<cr>",
        desc = "Current Word",
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("gh")
      telescope.load_extension("undo")
      telescope.load_extension("textcase")
      vim.api.nvim_set_keymap(
        "n",
        "ga.",
        "<cmd>TextCaseOpenTelescope<CR>",
        { desc = "Telescope" }
      )
      vim.api.nvim_set_keymap(
        "v",
        "ga.",
        "<cmd>TextCaseOpenTelescope<CR>",
        { desc = "Telescope" }
      )
    end,
  },
}
