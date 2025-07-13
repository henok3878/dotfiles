-- ~/.config/nvim/lua/configs/lspconfig.lua
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = { "pyright", "ts_ls", "lua_ls", "gopls", "rust_analyzer" }

local capabilities = require("nvchad.configs.lspconfig").capabilities
-- Enhanced capabilities for better completion
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

-- Enable hover and signature help
capabilities.textDocument.hover = {
  dynamicRegistration = true,
  contentFormat = { "markdown", "plaintext" },
}

capabilities.textDocument.signatureHelp = {
  dynamicRegistration = true,
  signatureInformation = {
    documentationFormat = { "markdown", "plaintext" },
    parameterInformation = {
      labelOffsetSupport = true,
    },
  },
}

-- Simple enhanced on_attach
local on_attach = function(client, bufnr)
  nvlsp.on_attach(client, bufnr)

  -- Add signature help in insert mode for better function documentation
  if client.server_capabilities.signatureHelpProvider then
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
  end
end

vim.lsp.enable(servers)

-- Enhanced Pyright for better Python IntelliSense
lspconfig.pyright.setup {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        completeFunctionParens = true,
        autoImportCompletions = true,
      },
    },
  },
}

-- TypeScript with function completion
lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
  settings = {
    typescript = {
      preferences = { completeFunctionCalls = true },
    },
    javascript = {
      preferences = { completeFunctionCalls = true },
    },
  },
}

-- Lua with essential Neovim globals
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
        },
        checkThirdParty = false,
      },
      completion = { callSnippet = "Replace" },
      telemetry = { enable = false },
    },
  },
}

-- Go with essential features
lspconfig.gopls.setup {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = { unusedparams = true },
    },
  },
}

-- Rust with clippy
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  on_init = nvlsp.on_init,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      completion = { addCallParentheses = true },
    },
  },
}

-- Better diagnostic display
vim.diagnostic.config {
  virtual_text = { prefix = "●" },
  float = { border = "rounded", source = true },
  signs = true,
  underline = true,
  severity_sort = true,
}
