-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.plugins = {
  options = {
    toggleterm = {
      close_on_exit = false,
      persist_mode = true,
      float_opts = {
        border = "single",
        width = 0.80,
        height = 0.60,
        col = 0.10,
        row = 0.10,
      },
    },
  },
}

M.base46 = {
  theme = "catppuccin",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
