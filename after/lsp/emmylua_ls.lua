---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      workspace = {
        -- library = {
        --   vim.env.VIMRUNTIME,
        --   "${3rd}/luv/library",
        --   vim.fn.stdpath("data") .. "/site/pack",
        -- },
      },
      completion = {
        callSnippet = true,
      },
    },
  },
}
