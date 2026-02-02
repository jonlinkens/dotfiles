-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.mouse = ""

vim.lsp.set_log_level("off")

vim.filetype.add({
  extension = {
    astro = "astro",
  },
})
