-- ~/.config/nvim/lua/plugins/mdx.lua
return {
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "mdx", "markdown" },
    config = true,
  },
}
