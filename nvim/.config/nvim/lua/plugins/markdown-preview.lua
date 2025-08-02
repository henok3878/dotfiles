return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
    ft = { "markdown", "md", "mdx" },
    -- use string build so lazy.nvim loads the plugin first
    build = ":call mkdp#util#install()",
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_math = 1
    end,
  },
}
