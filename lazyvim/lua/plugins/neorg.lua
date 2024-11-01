return {
  {
    "benlubas/neorg-conceal-wrap",
    ft = { "norg" },
    cmd = { "Neorg" },
  },
  {
    "benlubas/neorg-interim-ls",
    ft = { "norg" },
    cmd = { "Neorg" },
  },
  {
    "nvim-neorg/neorg",
    dependencies = {
      { "benlubas/neorg-conceal-wrap" },
      { "benlubas/neorg-interim-ls" },
    },
    ft = { "norg" },
    cmd = { "Neorg" },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/data/notes",
            },
          },
        },
        ["core.highlights"] = {},
        ["core.latex.renderer"] = {
          config = {
            render_on_enter = true,
          },
        },
        ["core.integrations.nvim-cmp"] = {},
        ["core.integrations.otter"] = {},
        ["external.conceal-wrap"] = {},
      },
    },
  },

  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      sources = { completion = { enabled_providers = { "neorg" } } },
      proviers = {
        neorg = {
          name = "neorg",
          module = "blink.compat.source",
          score_offset = 3,
        },
      },
    },
  },
}
