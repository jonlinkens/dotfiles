return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      javascript = { { "prettier" } },
      typescript = { { "prettier" } },
    },
  },
}
