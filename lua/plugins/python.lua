return {
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        search_venv_managers = false,
        search = false,
        parents = 5,
        name = {
          "venv",
          ".venv",
        },
      })
    end,
  },
}
