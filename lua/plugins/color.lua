return {
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "html" },
    config = true,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    config = function(_, opts)
      require("rainbow-delimiters.setup").setup(opts)
    end,
  },
}
