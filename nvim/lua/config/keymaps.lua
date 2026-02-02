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

vim.keymap.set("n", "<Up>", "")
vim.keymap.set("n", "<Down>", "")
vim.keymap.set("n", "<Left>", "")
vim.keymap.set("n", "<Right>", "")
vim.keymap.set("i", "<Up>", "")
vim.keymap.set("i", "<Down>", "")
vim.keymap.set("i", "<Left>", "")
vim.keymap.set("i", "<Right>", "")
vim.keymap.set("v", "<Up>", "")
vim.keymap.set("v", "<Down>", "")
vim.keymap.set("v", "<Left>", "")
vim.keymap.set("v", "<Right>", "")

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

vim.keymap.set("n", "<leader>co", ":TSToolsOrganizeImports <CR>", { desc = "Organize Imports" })

vim.keymap.set("n", "<leader>yf", function()
  vim.fn.setreg(vim.v.register, vim.fn.expand("%:t"))
end, { desc = "Yank filename" })

vim.keymap.set("n", "<leader>yp", function()
  local rel = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
  vim.fn.setreg(vim.v.register, rel)
end, { desc = "Yank project-relative path" })
