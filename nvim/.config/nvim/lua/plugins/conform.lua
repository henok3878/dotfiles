---@type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    format_on_save = {
      timeout_ms = 5000,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      python = { "isort", "black" },
      cpp = { "clang-format" },
      c = { "clang-format" },
      typescript = { "prettier" },
      yaml = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      rust = { "rustfmt" },
      go = { "gofumpt", "goimports" },
    },
  },
}
