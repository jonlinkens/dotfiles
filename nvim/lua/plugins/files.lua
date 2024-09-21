return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = "false",
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
    },
    opts = {
      filesystem = {
        hijack_netrw_behavior = "disabled",
      },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>e",
        "<cmd>Yazi<cr>",
        desc = "Open yazi (cwd)",
      },
      {
        "<leader>E",
        "<cmd>Yazi cwd<cr>",
        desc = "Open yazi (root dir)",
      },
    },
    opts = {
      open_for_directories = true,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
}
