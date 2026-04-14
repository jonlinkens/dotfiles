local find_files_opts = {
  win = {
    input = {
      keys = {
        ["<C-g>"] = {
          "toggle_live",
          mode = { "n", "i" },
        },
        ["<S-Tab>"] = {
          "go_to_live_grep",
          mode = { "n", "i" },
          nowait = true,
        },
      },
    },
  },
}

local live_grep_opts = {
  win = {
    input = {
      keys = {
        ["<C-g>"] = {
          "toggle_live",
          mode = { "n", "i" },
        },
        ["<S-Tab>"] = {
          "go_to_find_files",
          mode = { "n", "i" },
          nowait = true,
        },
      },
    },
  },
}

local fuzzy_grep_opts = vim.deepcopy(live_grep_opts)
fuzzy_grep_opts.grep_mode = { "fuzzy", "plain", "regex" }

return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>ff", false },
    },
    opts = function(_, opts)
      opts = opts or {}
      opts.input = opts.input or {}
      opts.picker = opts.picker or {}
      opts.picker.actions = opts.picker.actions or {}

      opts.picker.actions.go_to_live_grep = function(picker)
        picker:close()
        live_grep_opts.search = picker.input.filter.search
        require("fff-snacks").live_grep(live_grep_opts)
      end

      opts.picker.actions.go_to_find_files = function(picker)
        picker:close()
        find_files_opts.search = picker.input.filter.search
        require("fff-snacks").find_files(find_files_opts)
      end
    end,
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>ff", false },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", false },
    },
  },
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
    "dmtrKovalenko/fff.nvim",
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    lazy = false,
    opts = {
      lazy_sync = true,
    },
  },
  {
    "madmaxieee/fff-snacks.nvim",
    lazy = false,
    keys = {
      {
        "<leader>ff",
        function()
          require("fff-snacks").find_files(find_files_opts)
        end,
        desc = "FFF find files",
      },
      {
        "<leader>fw",
        function()
          require("fff-snacks").live_grep(live_grep_opts)
        end,
        desc = "FFF live grep",
      },
      {
        mode = "v",
        "<leader>fw",
        function()
          require("fff-snacks").grep_word(live_grep_opts)
        end,
        desc = "FFF grep word",
      },
      {
        "<leader>fz",
        function()
          require("fff-snacks").live_grep(fuzzy_grep_opts)
        end,
        desc = "FFF live grep (fuzzy)",
      },
    },
  },
}
