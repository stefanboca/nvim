local M = {}

---@param name string
function M.lspconfig(name)
  local lspconfig = loadfile(vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig/lsp/" .. name .. ".lua")
  if lspconfig ~= nil then return lspconfig() end
end

return M
