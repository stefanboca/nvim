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
    opts = function(_, opts)
      local rainbow_delimiters = require("rainbow-delimiters")
      return {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
          latex = "rainbow-blocks",
          lua = "rainbow-blocks",
        },
      }
    end,
  },
}
