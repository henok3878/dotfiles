---@type LazyPluginSpec
return {
  "stevearc/conform.nvim",
  ft = { "python", "cpp", "typescript", "lua" },
  opts = {
    format_on_save = {
      timeout_ms = 5000,
      lsp_fallback = true,
    },
    stop_after_first = true,
    formatters_by_ft = {
      python = { "black" },
      cpp = { "clang-format" },
      typescript = { "prettier" },
      lua = { "stylua" },
    },
  },
}
