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
