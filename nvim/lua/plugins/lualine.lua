return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.sections.lualine_a = {
      {
        "mode",
        fmt = function(str)
          return str:lower()
        end,
      },
    }
    opts.sections.lualine_c = { { "filename", path = 1 } }
    opts.options = {
      section_separators = { left = "", right = "" },
      component_separators = { left = "│", right = "│" },
    }
  end,
}
