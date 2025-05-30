; extends

; ---@language python
; local code = "def main(): ..."
((comment
  content: (_) @injection.language
  (#gsub! @injection.language "^[-][%s]*@language[%s]+(%S+)" "%1"))
  .
  ; allow type annotations between @language and variable declaration
  (comment
    content: (_) @_content
    (#lua-match? @_content "^[-][%s]*[@|]"))*
  .
  (variable_declaration
    (assignment_statement
      (expression_list
        value: (string
          content: (string_content) @injection.content)))))
