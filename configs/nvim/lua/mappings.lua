-- ~/.config/nvim/lua/mappings.lua

require "nvchad.mappings"

local map = vim.keymap.set
local fn = vim.fn
local term = require "nvchad.term"

-- jk → ESC in insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Copy to system clipboard with +y
map("v", "+y", '"+y', { desc = "Copy to system clipboard" })

-- Paste from system clipboard with +p
map("n", "+p", '"+p', { desc = "Paste from system clipboard" })

-- make <Esc> drop you back to Normal-mode from any terminal
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal: go to Normal mode" })

-- Tmux Navigator Mappings
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Move to left pane (vim or tmux)" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Move to pane below (vim or tmux)" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Move to pane above (vim or tmux)" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Move to right pane (vim or tmux)" })

-- Run all testcases (optional):
map("n", "<leader>tr", "<cmd>CompetiTest run<cr>", { desc = "CompetiTest: run all testcases" })

-- Add a new testcase by hand if you ever need it:
map("n", "<leader>ta", "<cmd>CompetiTest add_testcase<cr>", { desc = "CompetiTest: add testcase" })

-- ──────────────────────────────────────────────────────────────────────
-- Competitive Companion “Receive” Shortcuts:

-- 1) Listen once for a single practice problem:
map("n", "<leader>rp", "<cmd>CompetiTest receive problem<cr>", { desc = "CC → receive problem" })

-- 2) Listen once for an entire contest:
map("n", "<leader>rc", "<cmd>CompetiTest receive contest<cr>", { desc = "CC → receive contest" })

-- Toggle live Markdown/MDX preview
map("n", "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>", { desc = "Toggle Markdown/MDX preview" })
-- Run current Python/C/C++ file in a floating terminal
-- map("n", "<leader>r", function()
--   vim.cmd "write" -- save the current file first
--   local ft = vim.bo.filetype
--   local file = fn.expand "%:p" -- full path
--   local base = fn.expand "%:r" -- name without extension
--   if ft == "python" then
--     local python_cmd = "python"
--     local venv = os.getenv "VIRTUAL_ENV"
--     if venv and fn.executable(venv .. "/bin/python") == 1 then
--       python_cmd = venv .. "/bin/python"
--     elseif fn.executable "python" == 1 then
--       python_cmd = "python"
--     elseif fn.executable "python3" == 1 then
--       python_cmd = "python3"
--     end
--
--     term.runner {
--       id = "file_runner",
--       pos = "float",
--       cmd = function()
--         return python_cmd .. " " .. fn.shellescape(file)
--       end,
--     }
--   elseif ft == "cpp" or ft == "c" then
--     term.runner {
--       id = "file_runner",
--       pos = "float",
--       cmd = function()
--         return string.format(
--           "g++ -std=c++17 %s -o %s && ./%s",
--           fn.shellescape(file),
--           fn.shellescape(base),
--           fn.shellescape(base)
--         )
--       end,
--     }
--   else
--     vim.notify("No runner defined for filetype: " .. ft, vim.log.levels.WARN)
--   end
-- end, { desc = "Run or compile+run current file" })
--
-- Optional: map Ctrl+S to save in normal, insert, and visual modes
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
