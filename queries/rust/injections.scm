; extends

; let code = /* python */ "def main(): ...";
((block_comment) @injection.language
  .
  (string_literal
    (string_content) @injection.content)
  (#gsub! @injection.language "/%*%s*([%w%p]+)%s*%*/" "%1"))
