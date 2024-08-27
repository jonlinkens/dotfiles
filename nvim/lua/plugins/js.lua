return {
  "vuki656/package-info.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  ft = "json",
  opts = {

    hide_up_to_date = true,
    hide_unstable_versions = true,
    colors = { -- specify both colors
      invalid = "#F38BA8",
      outdated = "#6C7086",
    },
  },
  config = function(_, opts)
    require("package-info").setup(opts)

    -- manually register them
    vim.cmd([[highlight PackageInfoUpToDateVersion guifg=]] .. opts.colors.invalid)
    vim.cmd([[highlight PackageInfoOutdatedVersion guifg=]] .. opts.colors.outdated)
  end,
}
