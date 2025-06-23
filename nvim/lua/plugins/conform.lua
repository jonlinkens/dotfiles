return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    notify_on_error = true,
    formatters = {
      biome = { require_cwd = true },
      ["biome-check"] = { require_cwd = true },
      prettier = { require_cwd = true },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      ["javascript"] = { "biome-check", "prettier", stop_after_first = true },
      ["javascriptreact"] = { "biome-check", "prettier", stop_after_first = true },
      ["typescript"] = { "biome-check", "prettier", stop_after_first = true },
      ["typescriptreact"] = { "biome-check", "prettier", stop_after_first = true },
      ["json"] = { "biome-check", "prettier", stop_after_first = true },
    },
  },
}
