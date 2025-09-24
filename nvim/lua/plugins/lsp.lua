return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        astro = {},
        tsserver = {
          enabled = false,
        },
        ts_ls = {
          enabled = false,
        },
        vtsls = {
          enabled = false,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "astro",
        "tsx",
        "typescript",
        "html",
        "python",
        "json",
        "yaml",
        "lua",
        "javascript",
        "bash",
        "regex",
        "query",
        "markdown",
        "markdown_inline",
        "vim",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        code_lens = "off",
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        tsserver_path = nil,
        tsserver_max_memory = 10000,
        tsserver_format_options = {},
        tsserver_locale = "en",
        disable_member_code_lens = true,
      },
    },
  },
}
