local find_files_opts = {
  title = "Files",
  supports_live = true,
  icons = {
    ui = {
      live = "",
    },
  },
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
  title = "Grep",
  supports_live = true,
  icons = {
    ui = {
      live = "",
    },
  },
  toggles = {
    _is_grep_mode_plain = false,
    _is_grep_mode_regex = false,
    _is_grep_mode_fuzzy = false,
  },
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
fuzzy_grep_opts.title = "Fuzzy Grep"
fuzzy_grep_opts.grep_mode = { "fuzzy", "plain", "regex" }

local function picker_opts(opts, search)
  local copy = vim.deepcopy(opts)
  copy.search = search
  return copy
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader><space>", false },
      { "<leader>sg", false },
      { "<leader>sz", false },
    },
    opts = function(_, opts)
      opts = opts or {}
      opts.input = opts.input or {}
      opts.picker = opts.picker or {}
      opts.picker.actions = opts.picker.actions or {}

      opts.picker.actions.go_to_live_grep = function(picker)
        picker:close()
        require("fff-snacks").live_grep(picker_opts(live_grep_opts, picker.input.filter.search))
      end

      opts.picker.actions.go_to_find_files = function(picker)
        picker:close()
        require("fff-snacks").find_files(picker_opts(find_files_opts, picker.input.filter.search))
      end
    end,
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>space", false },
      { "<leader>sg", false },
      { "<leader>sz", false },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>space", false },
      { "<leader>sg", false },
      { "<leader>sz", false },
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
        "<leader><space>",
        function()
          require("fff-snacks").find_files(picker_opts(find_files_opts))
        end,
        desc = "FFF find files",
      },
      {
        "<leader>sg",
        function()
          require("fff-snacks").live_grep(picker_opts(live_grep_opts))
        end,
        desc = "FFF live grep",
      },
      {
        mode = "v",
        "<leader>sg",
        function()
          require("fff-snacks").grep_word(picker_opts(live_grep_opts))
        end,
        desc = "FFF grep word",
      },
      {
        "<leader>sz",
        function()
          require("fff-snacks").live_grep(picker_opts(fuzzy_grep_opts))
        end,
        desc = "FFF live grep (fuzzy)",
      },
    },
  },
}
