return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "norg" },
    })
  end,

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
        per_filetype = { neorg = { "neorg" } },
        providers = {
          neorg = {
            name = "nerog",
            module = "blink.compat.source",
          },
        },
      },
    },
  },
}
