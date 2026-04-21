local find_files_opts = {
  title = "Files",
  supports_live = true,
  formatters = {
    file = {
      filename_first = false,
      truncate = "left",
      min_width = 60,
    },
  },
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
  formatters = {
    file = {
      filename_first = false,
      truncate = "left",
      min_width = 60,
    },
  },
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

local function fff_root()
  if _G.LazyVim and LazyVim.root and LazyVim.root.git then
    return LazyVim.root.git()
  end

  local git_dir = vim.fs.find(".git", { path = vim.uv.cwd(), upward = true })[1]
  return git_dir and vim.fs.dirname(git_dir) or vim.uv.cwd()
end

local function picker_opts(opts, search, extra)
  local copy = vim.deepcopy(opts)
  copy.search = search
  if extra then
    copy = vim.tbl_deep_extend("force", copy, extra)
  end
  return copy
end

local function open_fff(method, opts)
  local cwd = fff_root()
  require("fff").change_indexing_directory(cwd)
  require("fff-snacks")[method](picker_opts(opts, nil, { cwd = cwd }))
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
        require("fff").change_indexing_directory(picker.opts.cwd)
        require("fff-snacks").live_grep(picker_opts(live_grep_opts, picker.input.filter.search, { cwd = picker.opts.cwd }))
      end

      opts.picker.actions.go_to_find_files = function(picker)
        picker:close()
        require("fff").change_indexing_directory(picker.opts.cwd)
        require("fff-snacks").find_files(picker_opts(find_files_opts, picker.input.filter.search, { cwd = picker.opts.cwd }))
      end
    end,
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", false },
      { "<leader>space", false },
      { "<leader>sg", false },
      { "<leader>sz", false },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader><space>", false },
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
          open_fff("find_files", find_files_opts)
        end,
        desc = "FFF find files",
      },
      {
        "<leader>sg",
        function()
          open_fff("live_grep", live_grep_opts)
        end,
        desc = "FFF live grep",
      },
      {
        mode = "v",
        "<leader>sg",
        function()
          open_fff("grep_word", live_grep_opts)
        end,
        desc = "FFF grep word",
      },
      {
        "<leader>sz",
        function()
          open_fff("live_grep", fuzzy_grep_opts)
        end,
        desc = "FFF live grep (fuzzy)",
      },
    },
  },
}
