; extends

; ---@language python
; local code = "def main(): ..."
((comment
  content: (_) @injection.language
  (#gsub! @injection.language "[-][%s]*@language[%s]+(%S+)[%s]*" "%1"))
  .
  (variable_declaration
    (assignment_statement
      (expression_list
        value: (string
          content: (string_content) @injection.content)))))
