return {
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = {
  --   transparent_background = true,
  -- } },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      styles = {
        transparency = true,
        italic = false,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
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
  {
    "rktjmp/lush.nvim",
    -- if you wish to use your own colorscheme:
    -- { dir = '/absolute/path/to/colorscheme', lazy = true },
  },
  {
    "shortcuts/no-neck-pain.nvim",
    keys = {
      {
        "<leader>uu",
        "<cmd>NoNeckPain<cr>",
        desc = "Centre buffer",
      },
    },
    opts = {
      width = 200,
      noremap = true,
    },
  },
}
