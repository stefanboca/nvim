return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        window = {
          fuzzy_finder_mappings = {
            ["<c-j>"] = "move_cursor_down",
            ["<c-k>"] = "move_cursor_up",
          },
        },
      },
    },
  },
}
