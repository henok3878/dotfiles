return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "json",
        "python",
        "cpp",
        "typescript",
        "markdown",
        "markdown_inline",
        "tsx",
      },
      highlight = { enable = true },
      indent = {
        enable = true,
        disable = { "python", "cpp" },
      },
    },
  },
}
