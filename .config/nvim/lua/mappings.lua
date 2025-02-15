require "nvchad.mappings"

-- Disable default mappings
local nomap = vim.keymap.del

nomap("n", "<leader>wK")
nomap("n", "<leader>wk")
nomap("n", "<leader>e")

-- Custom mappings

local map = vim.keymap.set

-- TODO: these were included with nvchad, do I actually need thes
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Save
map("n", "<leader>w", "<cmd>w<CR>", { desc = "general save file" })

-- Explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "nvimtree" })

-- whichkey
map("n", "<leader>kK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map("n", "<leader>kk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })
