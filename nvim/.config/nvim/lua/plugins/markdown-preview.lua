return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
    ft = { "markdown", "mdx" },
    -- use string build so lazy.nvim loads the plugin first
    build = ":call mkdp#util#install()",
    init = function()
      vim.g.mkdp_filetypes = {"markdown", "mdx"}
    end, 
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_math = 1
    end,
  },
}
