return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
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
}
