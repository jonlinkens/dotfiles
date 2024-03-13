return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      javascript = { { "biome", "prettier" } },
      typescript = { { "biome", "prettier" } },
    },
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
}
