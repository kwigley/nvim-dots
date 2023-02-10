return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources =
        cmp.config.sources(vim.list_extend(opts.sources, { { name = "copilot" } }))
      opts.sorting = {
        priority_weight = 2,
        comparators = {
          require("copilot_cmp.comparators").prioritize,
          require("copilot_cmp.comparators").score,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          require("cmp-under-comparator").under,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
      })
    end,
    dependencies = {
      { "lukas-reineke/cmp-under-comparator" },
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup({
            method = "getCompletionsCycling",
            formatters = {
              insert_text = require("copilot_cmp.format").remove_existing,
            },
          })
        end,
        dependencies = {
          {
            "zbirenbaum/copilot.lua",
            config = true,
            opts = {
              suggestion = { enabled = false },
              panel = { enabled = false },
              filetypes = {
                TelescopePrompt = false,
                TelescopeResults = false,
                yaml = true,
              },
            },
          },
        },
      },
    },
  },
}
