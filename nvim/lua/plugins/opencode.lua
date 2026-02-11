return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  init = function()
    vim.g.opencode_opts = {
      prompts = {
        ask_append = false,
        ask_this = false,
        diagnostics = false,
        diff = false,
        document = false,
        explain = false,
        fix = false,
        implement = false,
        optimize = false,
        review = false,
        test = false,
      },
    }
    vim.o.autoread = true
  end,

  config = function()
    local function get_function_name()
      local node = vim.treesitter.get_node()

      if not node then
        return nil
      end

      while node do
        local node_type = node:type()

        if node_type:match("function") or node_type:match("method") then
          local name_node = node:field("name")[1]
          if name_node then
            return vim.treesitter.get_node_text(name_node, 0)
          end
        end

        node = node:parent()
      end

      return nil
    end

    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })

    vim.keymap.set({ "n", "x" }, "<leader>ob", function()
      require("opencode").ask("@buffers: ", { submit = true })
    end, { desc = "Ask opencode about buffers" })

    vim.keymap.set({ "n", "x" }, "<leader>ox", function()
      require("opencode").select()
    end, { desc = "Execute opencode action…" })

    vim.keymap.set({ "n", "x" }, "<leader>or", function()
      return require("opencode").operator("@this ")
    end, { desc = "Add range to opencode", expr = true })

    vim.keymap.set("n", "<leader>ol", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<leader>oR", function()
      require("opencode").ask("/review ", { submit = true })
    end, { desc = "Run /review command" })

    vim.keymap.set("n", "<leader>oS", function()
      require("opencode").ask("/review-skim", { submit = true })
    end, { desc = "Run /review-skim command" })

    vim.keymap.set("n", "<leader>od", function()
      require("opencode").ask("@diagnostics: ", { submit = true })
    end, { desc = "Ask opencode about diagnostics" })

    vim.keymap.set("n", "<leader>oq", function()
      require("opencode").ask("@quickfix: ", { submit = true })
    end, { desc = "Ask opencode about quickfix list" })

    vim.keymap.set("n", "<leader>ot", function()
      local filepath = vim.fn.expand("%:~:.")
      local function_name = get_function_name()

      if function_name then
        vim.notify("Writing tests for " .. function_name .. "...")
        require("opencode").ask("/test " .. filepath .. ", " .. function_name, { submit = true })
      else
        vim.notify("Writing tests for " .. filepath .. "...")
        require("opencode").ask("/test " .. filepath, { submit = true })
      end
    end, { desc = "Test function under cursor" })
  end,
}
