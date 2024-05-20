return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "tsakirist/telescope-lazy.nvim" },
      {
        "nvim-telescope/telescope-fzy-native.nvim",
        config = function()
          require("telescope").load_extension("fzy_native")
        end,
      },
      {
        "johmsalas/text-case.nvim",
        config = function()
          require("textcase").setup({})
          require("telescope").load_extension("textcase")
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
    },
    opts = {
      defaults = {
        path_display = { "smart" },
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
      },
    },
  },
}
