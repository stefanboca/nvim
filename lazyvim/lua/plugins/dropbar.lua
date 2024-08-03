return {
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    event = { "LazyFile" },
    keys = {
      {
        "<leader>fd",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Pick file (dropbar)",
      },
    },
  },
}
