MiniDeps.now(function()
  MiniDeps.add({ name = "catppuccin", source = "catppuccin/nvim" })

  local catppuccin = require("catppuccin")
  catppuccin.setup({
    background = { dark = "mocha" },
    dim_inactive = { enabled = true },
    lsp_styles = { enabled = true },
    auto_integrations = true,
    custom_highlights = function(C)
      local hls = {
        MatchParen = { fg = "NONE", bg = C.surface1, style = { "bold" } },

        -- Use fg insted of bg
        ["@comment.error"] = { fg = C.red, bg = "NONE" },
        ["@comment.warning"] = { fg = C.yellow, bg = "NONE" },
        ["@comment.hint"] = { fg = C.blue, bg = "NONE" },
        ["@comment.todo"] = { fg = C.flamingo, bg = "NONE" },
        ["@comment.note"] = { fg = C.rosewater, bg = "NONE" },

        -- Remove italic, make underline blue
        MiniTablineCurrent = { fg = C.text, bg = C.base, sp = C.blue, style = { "bold", "underline" } },
        -- Remove italic, add blue underline
        MiniTablineModifiedCurrent = { fg = C.red, bg = C.none, sp = C.blue, style = { "bold", "underline" } },
        -- Make it more readable
        MiniTablineTabpagesection = { fg = C.text, bg = C.mantle },
      }

      local function blink_hl(color, fg)
        hls["BlinkPairs" .. color] = { fg = fg }
        hls["BlinkIndent" .. color] = { fg = fg }
      end

      blink_hl("Red", C.red)
      blink_hl("Orange", C.peach)
      blink_hl("Yellow", C.yellow)
      blink_hl("Green", C.green)
      blink_hl("Cyan", C.teal)
      blink_hl("Blue", C.blue)
      blink_hl("Violet", C.mauve)

      return hls
    end,
  })
  catppuccin.load()
end)
