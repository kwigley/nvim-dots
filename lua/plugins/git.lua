return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>gy",
        function()
          Snacks.gitbrowse({
            open = function(url)
              vim.fn.setreg("+", url)
              vim.notify("Git link yanked: " .. url)
            end,
            notify = false,
          })
        end,
        mode = { "n", "v" },
        desc = "Yank git link",
      },
      {
        "<leader>gY",
        function()
          Snacks.gitbrowse()
        end,
        mode = { "n", "v" },
        desc = "Open git link",
      },
    },
  },
}
