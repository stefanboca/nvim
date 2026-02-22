; extends

((ident) @constant
  (#eq? @constant "compose")
  (#has-ancestor? @constant formula)
  (#set! conceal "∘"))

((ident) @constant
  (#eq? @constant "dot")
  (#has-ancestor? @constant formula)
  (#set! conceal "·"))

((ident) @constant
  (#eq? @constant "dots")
  (#has-ancestor? @constant formula)
  (#set! conceal "…"))

((field) @constant
  (#eq? @constant "dots.c")
  (#has-ancestor? @constant formula)
  (#set! conceal "⋯")
  (#set! priority 105))

((field) @constant
  (#eq? @constant "dots.down")
  (#has-ancestor? @constant formula)
  (#set! conceal "⋱")
  (#set! priority 105))

((field) @constant
  (#eq? @constant "dots.up")
  (#has-ancestor? @constant formula)
  (#set! conceal "⋰")
  (#set! priority 105))

((field) @constant
  (#eq? @constant "dots.v")
  (#has-ancestor? @constant formula)
  (#set! conceal "⋮")
  (#set! priority 105))

((ident) @constant
  (#eq? @constant "exists")
  (#has-ancestor? @constant formula)
  (#set! conceal "∃"))

((field) @constant
  (#eq? @constant "exists.not")
  (#has-ancestor? @constant formula)
  (#set! conceal "∄")
  (#set! priority 105))

((ident) @constant
  (#eq? @constant "forall")
  (#has-ancestor? @constant formula)
  (#set! conceal "∀"))

((ident) @constant
  (#eq? @constant "in")
  (#has-ancestor? @constant formula)
  (#set! conceal "∈"))

((field) @constant
  (#eq? @constant "in.not")
  (#has-ancestor? @constant formula)
  (#set! conceal "∉")
  (#set! priority 105))

((ident) @constant
  (#eq? @constant "integral")
  (#has-ancestor? @constant formula)
  (#set! conceal "∫"))

((ident) @constant
  (#eq? @constant "inter")
  (#has-ancestor? @constant formula)
  (#set! conceal "∩"))

((ident) @constant
  (#eq? @constant "oo")
  (#has-ancestor? @constant formula)
  (#set! conceal "∞"))

((ident) @constant
  (#eq? @constant "product")
  (#has-ancestor? @constant formula)
  (#set! conceal "∏"))

((ident) @constant
  (#eq? @constant "subset")
  (#has-ancestor? @constant formula)
  (#set! conceal "⊂"))

((field) @constant
  (#eq? @constant "subset.eq")
  (#has-ancestor? @constant formula)
  (#set! conceal "⊆")
  (#set! priority 105))

((ident) @constant
  (#eq? @constant "sum")
  (#has-ancestor? @constant formula)
  (#set! conceal "∑"))

((ident) @constant
  (#eq? @constant "supset")
  (#has-ancestor? @constant formula)
  (#set! conceal "⊃"))

((field) @constant
  (#eq? @constant "supset.not")
  (#has-ancestor? @constant formula)
  (#set! conceal "⊅")
  (#set! priority 105))

((ident) @constant
  (#eq? @constant "times")
  (#has-ancestor? @constant formula)
  (#set! conceal "×"))

((ident) @constant
  (#eq? @constant "union")
  (#has-ancestor? @constant formula)
  (#set! conceal "∪"))

((ident) @constant
  (#eq? @constant "without")
  (#has-ancestor? @constant formula)
  (#set! conceal "∖"))

((ident) @constant
  (#eq? @constant "partial")
  (#has-ancestor? @constant formula)
  (#set! conceal "∂"))

; blackboard letters
((ident) @constant
  (#eq? @constant "AA")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝔸"))

((ident) @constant
  (#eq? @constant "BB")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝔹"))

((ident) @constant
  (#eq? @constant "CC")
  (#has-ancestor? @constant formula)
  (#set! conceal "ℂ"))

((ident) @constant
  (#eq? @constant "DD")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝔻"))

((ident) @constant
  (#eq? @constant "EE")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝔼"))

((ident) @constant
  (#eq? @constant "FF")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝔽"))

((ident) @constant
  (#eq? @constant "GG")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝔾"))

((ident) @constant
  (#eq? @constant "HH")
  (#has-ancestor? @constant formula)
  (#set! conceal "ℍ"))

((ident) @constant
  (#eq? @constant "II")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕀"))

((ident) @constant
  (#eq? @constant "JJ")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕁"))

((ident) @constant
  (#eq? @constant "KK")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕂"))

((ident) @constant
  (#eq? @constant "LL")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕃"))

((ident) @constant
  (#eq? @constant "MM")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕄"))

((ident) @constant
  (#eq? @constant "NN")
  (#has-ancestor? @constant formula)
  (#set! conceal "ℕ"))

((ident) @constant
  (#eq? @constant "OO")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕆"))

((ident) @constant
  (#eq? @constant "PP")
  (#has-ancestor? @constant formula)
  (#set! conceal "ℙ"))

((ident) @constant
  (#eq? @constant "QQ")
  (#has-ancestor? @constant formula)
  (#set! conceal "ℚ"))

((ident) @constant
  (#eq? @constant "RR")
  (#has-ancestor? @constant formula)
  (#set! conceal "ℝ"))

((ident) @constant
  (#eq? @constant "SS")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕊"))

; TT is missing because it's used for matrix transpose, and isn't typeset in a blackbord font
((ident) @constant
  (#eq? @constant "UU")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕌"))

((ident) @constant
  (#eq? @constant "VV")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕍"))

((ident) @constant
  (#eq? @constant "WW")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕎"))

((ident) @constant
  (#eq? @constant "XX")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕏"))

((ident) @constant
  (#eq? @constant "YY")
  (#has-ancestor? @constant formula)
  (#set! conceal "𝕐"))

((ident) @constant
  (#eq? @constant "ZZ")
  (#has-ancestor? @constant formula)
  (#set! conceal "ℤ"))

; lowercase greek letters
((ident) @constant
  (#eq? @constant "alpha")
  (#has-ancestor? @constant formula)
  (#set! conceal "α"))

((ident) @constant
  (#eq? @constant "beta")
  (#has-ancestor? @constant formula)
  (#set! conceal "β"))

((ident) @constant
  (#eq? @constant "gamma")
  (#has-ancestor? @constant formula)
  (#set! conceal "γ"))

((ident) @constant
  (#eq? @constant "delta")
  (#has-ancestor? @constant formula)
  (#set! conceal "δ"))

((ident) @constant
  (#eq? @constant "epsilon")
  (#has-ancestor? @constant formula)
  (#set! conceal "ε"))

((ident) @constant
  (#eq? @constant "zeta")
  (#has-ancestor? @constant formula)
  (#set! conceal "ζ"))

((ident) @constant
  (#eq? @constant "eta")
  (#has-ancestor? @constant formula)
  (#set! conceal "η"))

((ident) @constant
  (#eq? @constant "theta")
  (#has-ancestor? @constant formula)
  (#set! conceal "θ"))

((ident) @constant
  (#eq? @constant "iota")
  (#has-ancestor? @constant formula)
  (#set! conceal "ι"))

((ident) @constant
  (#eq? @constant "kappa")
  (#has-ancestor? @constant formula)
  (#set! conceal "κ"))

((ident) @constant
  (#eq? @constant "lambda")
  (#has-ancestor? @constant formula)
  (#set! conceal "λ"))

((ident) @constant
  (#eq? @constant "mu")
  (#has-ancestor? @constant formula)
  (#set! conceal "μ"))

((ident) @constant
  (#eq? @constant "nu")
  (#has-ancestor? @constant formula)
  (#set! conceal "ν"))

((ident) @constant
  (#eq? @constant "xi")
  (#has-ancestor? @constant formula)
  (#set! conceal "ξ"))

((ident) @constant
  (#eq? @constant "omicron")
  (#has-ancestor? @constant formula)
  (#set! conceal "ο"))

((ident) @constant
  (#eq? @constant "pi")
  (#has-ancestor? @constant formula)
  (#set! conceal "π"))

((ident) @constant
  (#eq? @constant "rho")
  (#has-ancestor? @constant formula)
  (#set! conceal "ρ"))

((ident) @constant
  (#eq? @constant "sigma")
  (#has-ancestor? @constant formula)
  (#set! conceal "σ"))

((ident) @constant
  (#eq? @constant "tau")
  (#has-ancestor? @constant formula)
  (#set! conceal "τ"))

((ident) @constant
  (#eq? @constant "upsilon")
  (#has-ancestor? @constant formula)
  (#set! conceal "υ"))

((ident) @constant
  (#eq? @constant "phi")
  (#has-ancestor? @constant formula)
  (#set! conceal "φ"))

((ident) @constant
  (#eq? @constant "chi")
  (#has-ancestor? @constant formula)
  (#set! conceal "χ"))

((ident) @constant
  (#eq? @constant "psi")
  (#has-ancestor? @constant formula)
  (#set! conceal "ψ"))

((ident) @constant
  (#eq? @constant "omega")
  (#has-ancestor? @constant formula)
  (#set! conceal "ω"))

; uppercase greek letters
((ident) @constant
  (#eq? @constant "Alpha")
  (#has-ancestor? @constant formula)
  (#set! conceal "Α"))

((ident) @constant
  (#eq? @constant "Beta")
  (#has-ancestor? @constant formula)
  (#set! conceal "Β"))

((ident) @constant
  (#eq? @constant "Gamma")
  (#has-ancestor? @constant formula)
  (#set! conceal "Γ"))

((ident) @constant
  (#eq? @constant "Delta")
  (#has-ancestor? @constant formula)
  (#set! conceal "Δ"))

((ident) @constant
  (#eq? @constant "Epsilon")
  (#has-ancestor? @constant formula)
  (#set! conceal "Ε"))

((ident) @constant
  (#eq? @constant "Zeta")
  (#has-ancestor? @constant formula)
  (#set! conceal "Ζ"))

((ident) @constant
  (#eq? @constant "Eta")
  (#has-ancestor? @constant formula)
  (#set! conceal "Η"))

((ident) @constant
  (#eq? @constant "Theta")
  (#has-ancestor? @constant formula)
  (#set! conceal "Θ"))

((ident) @constant
  (#eq? @constant "Iota")
  (#has-ancestor? @constant formula)
  (#set! conceal "Ι"))

((ident) @constant
  (#eq? @constant "Kappa")
  (#has-ancestor? @constant formula)
  (#set! conceal "Κ"))

((ident) @constant
  (#eq? @constant "Lambda")
  (#has-ancestor? @constant formula)
  (#set! conceal "Λ"))

((ident) @constant
  (#eq? @constant "Mu")
  (#has-ancestor? @constant formula)
  (#set! conceal "Μ"))

((ident) @constant
  (#eq? @constant "Nu")
  (#has-ancestor? @constant formula)
  (#set! conceal "Ν"))

((ident) @constant
  (#eq? @constant "Xi")
  (#has-ancestor? @constant formula)
  (#set! conceal "Ξ"))

((ident) @constant
  (#eq? @constant "Omicron")
  (#has-ancestor? @constant formula)
  (#set! conceal "Ο"))

((ident) @constant
  (#eq? @constant "Pi")
  (#has-ancestor? @constant formula)
  (#set! conceal "Π"))

((ident) @constant
  (#eq? @constant "Rho")
  (#has-ancestor? @constant formula)
  (#set! conceal "Ρ"))

((ident) @constant
  (#eq? @constant "Sigma")
  (#has-ancestor? @constant formula)
  (#set! conceal "Σ"))

((ident) @constant
  (#eq? @constant "Tau")
  (#has-ancestor? @constant formula)
  (#set! conceal "Τ"))

((ident) @constant
  (#eq? @constant "Upsilon")
  (#has-ancestor? @constant formula)
  (#set! conceal "Υ"))

((ident) @constant
  (#eq? @constant "Phi")
  (#has-ancestor? @constant formula)
  (#set! conceal "Φ"))

((ident) @constant
  (#eq? @constant "Chi")
  (#has-ancestor? @constant formula)
  (#set! conceal "Χ"))

((ident) @constant
  (#eq? @constant "Psi")
  (#has-ancestor? @constant formula)
  (#set! conceal "Ψ"))

((ident) @constant
  (#eq? @constant "Omega")
  (#has-ancestor? @constant formula)
  (#set! conceal "Ω"))

; custom symbols
((ident) @constant
  (#eq? @constant "mbar")
  (#has-ancestor? @constant formula)
  (#set! conceal "∣"))

; disbaled because visually the same as inter and union
; ((field) @constant
;   (#eq? @constant "inter.big")
;   (#has-ancestor? @constant formula)
;   (#set! conceal "⋂")
;   (#set! priority 105))
; ((field) @constant
;   (#eq? @constant "union.big")
;   (#has-ancestor? @constant formula)
;   (#set! conceal "⋃")
;   (#set! priority 105))
