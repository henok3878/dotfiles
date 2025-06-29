-- ~/.config/nvim/lua/lsp/servers/clangd.lua
local nvlsp     = require("nvchad.configs.lspconfig")
local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--query-driver=/opt/homebrew/opt/gcc/bin/g++-*",
  },
  on_attach    = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
}
