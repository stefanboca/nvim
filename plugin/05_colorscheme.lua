MiniDeps.now(function()
  MiniDeps.add({ name = "catppuccin", source = "catppuccin/nvim" })

  local catppuccin = require("catppuccin")
  catppuccin.setup({
    background = { dark = "mocha" },
    dim_inactive = { enabled = true },
    lsp_styles = { enabled = true },
    auto_integrations = true,
    custom_highlights = function(c)
      local hls = {
        MatchParen = { fg = "NONE", bg = c.surface1, style = { "bold" } },
        ["@comment.error"] = { fg = c.red, bg = "NONE" },
        ["@comment.warning"] = { fg = c.yellow, bg = "NONE" },
        ["@comment.hint"] = { fg = c.blue, bg = "NONE" },
        ["@comment.todo"] = { fg = c.flamingo, bg = "NONE" },
        ["@comment.note"] = { fg = c.rosewater, bg = "NONE" },
      }

      local function pairs_hl(color, fg)
        hls["BlinkPairs" .. color] = { fg = fg }
        hls["BlinkIndentUnderline" .. color] = { default = true, sp = fg, underline = true }
      end

      pairs_hl("Red", c.red)
      pairs_hl("Orange", c.peach)
      pairs_hl("Yellow", c.yellow)
      pairs_hl("Green", c.green)
      pairs_hl("Cyan", c.teal)
      pairs_hl("Blue", c.blue)
      pairs_hl("Violet", c.mauve)

      return hls
    end,
  })
  catppuccin.load()
end)
