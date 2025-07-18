((tag
  (name) @comment.todo @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.todo "TODO" "WIP")
  (#set! "priority" 150))

("text" @comment.todo @nospell
  (#any-of? @comment.todo "TODO" "WIP")
  (#set! "priority" 150))

((tag
  (name) @comment.note @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.note "NOTE" "XXX" "INFO" "DOCS" "PERF" "TEST")
  (#set! "priority" 150))

("text" @comment.note @nospell
  (#any-of? @comment.note "NOTE" "XXX" "INFO" "DOCS" "PERF" "TEST")
  (#set! "priority" 150))

((tag
  (name) @comment.warning @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.warning "HACK" "WARNING" "WARN" "FIX")
  (#set! "priority" 150))

("text" @comment.warning @nospell
  (#any-of? @comment.warning "HACK" "WARNING" "WARN" "FIX")
  (#set! "priority" 150))

((tag
  (name) @comment.error @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.error "FIXME" "BUG" "ERROR")
  (#set! "priority" 150))

("text" @comment.error @nospell
  (#any-of? @comment.error "FIXME" "BUG" "ERROR")
  (#set! "priority" 150))

((tag
  (name) @comment.info @nospell
  ("(" @punctuation.bracket
    (user) @constant
    ")" @punctuation.bracket)?
  ":" @punctuation.delimiter)
  (#any-of? @comment.info "SAFETY" "INVARIANT")
  (#set! "priority" 150))

("text" @comment.info @nospell
  (#any-of? @comment.info "SAFETY" "INVARIANT" "Safety" "Invariant")
  (#set! "priority" 150))

; Issue number (#123)
("text" @number
  (#lua-match? @number "^#[0-9]+$")
  (#set! "priority" 150))

((uri) @string.special.url @nospell
  (#set! "priority" 150))
