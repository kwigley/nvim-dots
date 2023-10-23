return {
  {
    "linux-cultist/venv-selector.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        search_venv_managers = false,
        search = false,
        name = {
          "venv",
          ".venv",
        },
      })
    end,
  },
}
