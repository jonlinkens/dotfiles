-- vim.keymap.set("i", "<Tab>", function()
--   if require("copilot.suggestion").is_visible() then
--     require("copilot.suggestion").accept()
--   else
--     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
--   end
-- end, {
--   silent = true,
-- })

-- vim.api.nvim_set_keymap("n", "<leader>cpd", ":Copilot disable<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>cpe", ":Copilot enable<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("v", "y", "myy`y", { desc = "Yank and restore cursor position" })
vim.keymap.set("v", "Y", "myY`y", { desc = "Yank line and restore cursor position" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>cg",
  ":Mdpreview<CR>",
  { noremap = true, silent = true, desc = "Open markdown preview buffer" }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>gv",
  ":OpenInGHFile <CR>",
  { silent = true, noremap = true, desc = "Open in GitHub" }
)
vim.api.nvim_set_keymap(
  "v",
  "<Leader>gv",
  ":OpenInGHFileLines <CR>",
  { silent = true, noremap = true, desc = "Open lines in GitHub" }
)

vim.api.nvim_set_keymap(
  "n",
  "<Leader>t",
  ":GlobalNote <CR>",
  { silent = true, noremap = true, desc = "Open global note" }
)
