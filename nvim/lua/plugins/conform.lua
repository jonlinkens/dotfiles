return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      -- interchange biome with prettier or else it doesnt work...
      -- Make sure its installed with mason and conform

      javascript = { { "prettier" } },
      typescript = { { "prettier" } },
    },
  },
}
