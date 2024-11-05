return {
  { "benlubas/neorg-conceal-wrap", lazy = true },
  {
    "nvim-neorg/neorg",
    version = "*",
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
      sources = {
        completion = {
          enabled_providers = { "neorg" },
        },
        providers = {
          neorg = {
            name = "neorg",
            module = "blink.compat.source",
            score_offset = 3,
          },
        },
      },
    },
  },
}
