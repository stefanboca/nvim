; extends

; $|$
; to
; $
;   |
; $
(math
  "$" @indent.begin
  (_)*
  "$" @indent.end
  (#set! indent.immediate 1))

; $
;   foo
;     bar|
; $
; to
; $
;   foo
;     bar
;     |
; $
(math
  (formula)) @indent.auto
