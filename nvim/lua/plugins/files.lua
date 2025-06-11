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
  {
    "ibhagwan/fzf-lua",
    opts = {
      oldfiles = {
        include_current_session = true,
      },
      previewers = {
        builtin = {
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
      grep = {
        rg_glob = true, -- enable glob parsing
        glob_flag = "--iglob", -- case insensitive globs
      },
    },
    keys = {
      { "<leader>fF", LazyVim.pick("files"), desc = "Find Files (cwd)" },
      { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (Root files)" },
      { "<leader>sG", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sg", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    },
  },
}
