-- ~/.config/nvim/lua/lsp/servers/pyright.lua
local nvlsp     = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")

lspconfig.pyright.setup {
  -- always treat cwd as project root
  root_dir     = function() return vim.loop.cwd() end,
  on_attach    = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
}
