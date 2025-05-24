local utils = require("my.utils.tinymist")

---@type vim.lsp.Config
return {
  handlers = {
    ["tinymist/preview/scrollSource"] = utils.preview_scrollSource,
    ["tinymist/preview/dispose"] = utils.preview_dispose,
  },
  on_exit = vim.schedule_wrap(utils.on_exit),
}
