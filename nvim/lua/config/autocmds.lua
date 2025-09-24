-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- local function augroup(name)
--   return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
-- end
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = augroup("removeImports"),
--   pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
--   callback = function()
--     vim.lsp.buf.code_action({
--       apply = true,
--       context = {
--         only = { "source.removeUnusedImports.ts" },
--         diagnostics = {},
--       },
--     })
--   end,
-- })
--

-- when opening nvim with a directory (i.e. "nvim .")
-- open a blank buffer instead of netrw/etc.
-- this way I can easily choose between telescope or a file explorer (yazi atm)
-- probably not the best way to do this but who cares
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
      vim.cmd("cd " .. vim.fn.argv(0))
      vim.cmd("bwipeout 1")
      vim.cmd("enew")
    end
  end,
})

-- typescript code actions improvements
vim.api.nvim_create_autocmd({ "FileType" }, {
  once = true,
  group = vim.api.nvim_create_augroup("typescript-code-actions", { clear = true }),
  desc = "Improve TypeScript code actions",
  pattern = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  callback = function()
    local original_select = vim.ui.select

    local actions_to_sort_first = {
      "Update import",
      "Add import",
    }

    local actions_to_exclude = {
      "Move to a new file",
      "Move to file",
      "Change spelling to",
    }

    ---@diagnostic disable-next-line: duplicate-set-field
    vim.ui.select = function(items, opts, on_choice)
      if not opts or opts.kind ~= "codeaction" then
        return original_select(items, opts, on_choice)
      end

      local filtered_items = {}

      local lsp_clients = vim.lsp.get_clients({ name = "typescript-tools" })
      local typescript_client = lsp_clients[1]

      if not typescript_client then
        return original_select(items, opts, on_choice)
      end

      for _, item in ipairs(items) do
        local exclude = false

        if item.ctx.client_id ~= typescript_client.id then
          goto continue
        end

        for _, action in ipairs(actions_to_exclude) do
          if item.action and item.action.title and string.find(item.action.title, action) then
            exclude = true
            break
          end
        end

        ::continue::
        if not exclude then
          table.insert(filtered_items, item)
        end
      end

      local function get_priority(item)
        if not item.action or not item.action.title or item.ctx.client_id ~= typescript_client.id then
          return math.huge
        end

        for i, action in ipairs(actions_to_sort_first) do
          if string.find(item.action.title, action) then
            return i
          end
        end

        return math.huge
      end

      table.sort(filtered_items, function(a, b)
        return get_priority(a) < get_priority(b)
      end)

      original_select(filtered_items, opts, on_choice)
    end
  end,
})
