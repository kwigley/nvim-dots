return {
  "cshuaimin/ssr.nvim",
  keys = {
    {
      "<leader>cR",
      function()
        require("ssr").open()
      end,
      mode = { "n", "x" },
      desc = "Structural Replace",
    },
  },
}
