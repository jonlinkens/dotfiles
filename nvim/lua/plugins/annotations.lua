return {
  {
    "danymat/neogen",
    opts = { noremap = true, silent = true },
    version = "*",
    snippet_engine = "luasnip",

    languages = {
      javascript = {
        template = {
          annotation_convention = "jsdoc",
        },
      },
      typescript = {
        template = {
          annotation_convention = "tsdoc",
        },
      },
      typescriptreact = {
        template = {
          annotation_convention = "tsdoc",
        },
      },
    },

    keys = {
      {
        "<leader>ng",
        function()
          require("neogen").generate()
        end,
        desc = "generic annotation",
      },
      {
        "<leader>nc",
        function()
          require("neogen").generate({ type = "class" })
        end,
        desc = "class",
      },
      {
        "<leader>nf",
        function()
          require("neogen").generate({ type = "func" })
        end,
        desc = "function",
      },
      {
        "<leader>nt",
        function()
          require("neogen").generate({ type = "type" })
        end,
        desc = "type",
      },
    },
  },
}
