return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = {
    transparent_background = true,
  } },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  {
    "dstein64/nvim-scrollview",
  },
  {
    "neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          --visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".github",
            ".gitignore",
            "package-lock.json",
          },
          never_show = { ".git" },
        },
      },
    },
  },
}
