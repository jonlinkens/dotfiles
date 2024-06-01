return {
  {
    "mrjones2014/mdpreview.nvim",
    ft = "markdown",
    dependencies = { "norcalli/nvim-terminal.lua", config = true },
  },
  {
    "backdround/global-note.nvim",
    config = function()
      require("global-note").setup({
        window_config = function()
          local window_height = vim.api.nvim_list_uis()[1].height
          local window_width = vim.api.nvim_list_uis()[1].width
          return {
            relative = "editor",
            border = "single",
            title = "Note",
            title_pos = "center",
            width = math.floor(0.3 * window_width),
            height = math.floor(0.35 * window_height),
            row = math.floor(0.35 * window_height),
            col = math.floor(0.35 * window_width),
          }
        end,
      })
    end,
  },
}
