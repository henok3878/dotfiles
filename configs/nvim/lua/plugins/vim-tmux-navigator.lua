-- ~/.config/nvim/lua/plugins/vim-tmux-navigator.lua
return {
  "christoomey/vim-tmux-navigator",
  lazy = false, -- load on startup
  config = function()
    -- disable the plugin’s default mappings so we can set our own
    vim.g.tmux_navigator_no_mappings = 1
  end,
}
