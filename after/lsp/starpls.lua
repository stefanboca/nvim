---@type vim.lsp.Config
return {
  cmd = {
    "starpls",
    "server",
    "--experimental_enable_label_completions",
    "--experimental_goto_definition_skip_re_exports",
    "--experimental_infer_ctx_attributes",
    "--experimental_use_code_flow_analysis",
  },
}
