vim.b.indent_guide = false
vim.bo.textwidth = 100
vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.opt_local.formatoptions:append("t")

if vim.g.sigil_init then return end
vim.g.sigil_init = true

vim.cmd.packadd("sigil.nvim")

require("sigil").setup({
  filetypes = { "typst" },
  hl_group = "@constant.tyst",
  atomic_motions = false,
  unprettify_at_point = true,
  filetype_symbols = {
    typst = {
      math = {
        -- builtin symbols
        -- keep-sorted start
        { pattern = "compose", replacement = "∘", boundary = "both" },
        { pattern = "dot", replacement = "·", boundary = "both" },
        { pattern = "dots", replacement = "…", boundary = "both" },
        { pattern = "dots.c", replacement = "⋯", boundary = "both" },
        { pattern = "dots.down", replacement = "⋱", boundary = "both" },
        { pattern = "dots.up", replacement = "⋰", boundary = "both" },
        { pattern = "dots.v", replacement = "⋮", boundary = "both" },
        { pattern = "exists", replacement = "∃", boundary = "both" },
        { pattern = "exists.not", replacement = "∄", boundary = "both" },
        { pattern = "forall", replacement = "∀", boundary = "both" },
        { pattern = "in", replacement = "∈", boundary = "both" },
        { pattern = "in.not", replacement = "∉", boundary = "both" },
        { pattern = "integral", replacement = "∫", boundary = "left" },
        { pattern = "inter", replacement = "∩", boundary = "both" },
        { pattern = "oo", replacement = "∞", boundary = "left" },
        { pattern = "product", replacement = "∏", boundary = "left" },
        { pattern = "subset", replacement = "⊂", boundary = "both" },
        { pattern = "subset.eq", replacement = "⊆", boundary = "both" },
        { pattern = "sum", replacement = "∑", boundary = "left" },
        { pattern = "supset", replacement = "⊃", boundary = "both" },
        { pattern = "supset.not", replacement = "⊅", boundary = "both" },
        { pattern = "times", replacement = "×", boundary = "both" },
        { pattern = "union", replacement = "∪", boundary = "both" },
        { pattern = "without", replacement = "∖", boundary = "both" },
        -- keep-sorted end

        -- custom symbols
        -- keep-sorted start
        -- { pattern = "iff", replacement = "⟺  ", boundary = "both" },
        -- { pattern = "impl", replacement = "⟹  ", boundary = "both" },
        { pattern = "mbar", replacement = "∣", boundary = "both" },
        -- keep-sorted end

        -- blackboard letters
        -- keep-sorted start
        { pattern = "AA", replacement = "𝔸" },
        { pattern = "BB", replacement = "𝔹" },
        { pattern = "CC", replacement = "ℂ" },
        { pattern = "DD", replacement = "𝔻" },
        { pattern = "EE", replacement = "𝔼" },
        { pattern = "FF", replacement = "𝔽" },
        { pattern = "GG", replacement = "𝔾" },
        { pattern = "HH", replacement = "ℍ" },
        { pattern = "II", replacement = "𝕀" },
        { pattern = "JJ", replacement = "𝕁" },
        { pattern = "KK", replacement = "𝕂" },
        { pattern = "LL", replacement = "𝕃" },
        { pattern = "MM", replacement = "𝕄" },
        { pattern = "NN", replacement = "ℕ" },
        { pattern = "OO", replacement = "𝕆" },
        { pattern = "PP", replacement = "ℙ" },
        { pattern = "QQ", replacement = "ℚ" },
        { pattern = "RR", replacement = "ℝ" },
        { pattern = "SS", replacement = "𝕊" },
        -- { pattern = "TT", replacement = "𝕋" },
        { pattern = "UU", replacement = "𝕌" },
        { pattern = "VV", replacement = "𝕍" },
        { pattern = "WW", replacement = "𝕎" },
        { pattern = "XX", replacement = "𝕏" },
        { pattern = "YY", replacement = "𝕐" },
        { pattern = "ZZ", replacement = "ℤ" },
        -- keep-sorted end

        -- lowercase greek letters
        { pattern = "alpha", replacement = "α", boundary = "left" },
        { pattern = "beta", replacement = "β", boundary = "left" },
        { pattern = "gamma", replacement = "γ", boundary = "left" },
        { pattern = "delta", replacement = "δ", boundary = "left" },
        { pattern = "epsilon", replacement = "ε", boundary = "left" },
        { pattern = "zeta", replacement = "ζ", boundary = "left" },
        { pattern = "eta", replacement = "η", boundary = "left" },
        { pattern = "theta", replacement = "θ", boundary = "left" },
        { pattern = "iota", replacement = "ι", boundary = "left" },
        { pattern = "kappa", replacement = "κ", boundary = "left" },
        { pattern = "lambda", replacement = "λ", boundary = "left" },
        { pattern = "mu", replacement = "μ", boundary = "left" },
        { pattern = "nu", replacement = "ν", boundary = "left" },
        { pattern = "xi", replacement = "ξ", boundary = "left" },
        { pattern = "omicron", replacement = "ο", boundary = "left" },
        { pattern = "pi", replacement = "π", boundary = "left" },
        { pattern = "rho", replacement = "ρ", boundary = "left" },
        { pattern = "sigma", replacement = "σ", boundary = "left" },
        { pattern = "tau", replacement = "τ", boundary = "left" },
        { pattern = "upsilon", replacement = "υ", boundary = "left" },
        { pattern = "phi", replacement = "φ", boundary = "left" },
        { pattern = "chi", replacement = "χ", boundary = "left" },
        { pattern = "psi", replacement = "ψ", boundary = "left" },
        { pattern = "omega", replacement = "ω", boundary = "left" },

        -- upercase greek letters
        { pattern = "Alpha", replacement = "Α", boundary = "left" },
        { pattern = "Beta", replacement = "Β", boundary = "left" },
        { pattern = "Gamma", replacement = "Γ", boundary = "left" },
        { pattern = "Delta", replacement = "Δ", boundary = "left" },
        { pattern = "Epsilon", replacement = "Ε", boundary = "left" },
        { pattern = "Zeta", replacement = "Ζ", boundary = "left" },
        { pattern = "Eta", replacement = "Η", boundary = "left" },
        { pattern = "Theta", replacement = "Θ", boundary = "left" },
        { pattern = "Iota", replacement = "Ι", boundary = "left" },
        { pattern = "Kappa", replacement = "Κ", boundary = "left" },
        { pattern = "Lambda", replacement = "Λ", boundary = "left" },
        { pattern = "Mu", replacement = "Μ", boundary = "left" },
        { pattern = "Nu", replacement = "Ν", boundary = "left" },
        { pattern = "Xi", replacement = "Ξ", boundary = "left" },
        { pattern = "Omicron", replacement = "Ο", boundary = "left" },
        { pattern = "Pi", replacement = "Π", boundary = "left" },
        { pattern = "Rho", replacement = "Ρ", boundary = "left" },
        { pattern = "Sigma", replacement = "Σ", boundary = "left" },
        { pattern = "Tau", replacement = "Τ", boundary = "left" },
        { pattern = "Upsilon", replacement = "Υ", boundary = "left" },
        { pattern = "Phi", replacement = "Φ", boundary = "left" },
        { pattern = "Chi", replacement = "Χ", boundary = "left" },
        { pattern = "Psi", replacement = "Ψ", boundary = "left" },
        { pattern = "Omega", replacement = "Ω", boundary = "left" },

        -- disabled because visually the same as inter and union
        -- { pattern = "inter.big", replacement = "⋂", boundary = "left" },
        -- { pattern = "union.big", replacement = "⋃", boundary = "left" },
      },
    },
  },
})
