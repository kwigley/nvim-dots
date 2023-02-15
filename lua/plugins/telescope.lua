return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-github.nvim" },
      { "johmsalas/text-case.nvim", config = true },
    },
    opts = {
      defaults = {
        path_display = { "smart" }, -- { "truncate" },
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
