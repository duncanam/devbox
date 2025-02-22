require "nvchad.mappings"

-- Disable default mappings
local nomap = vim.keymap.del

nomap("n", "<leader>wK")
nomap("n", "<leader>wk")
nomap("n", "<leader>e")

-- Custom mappings

local map = vim.keymap.set

-- Save
map("n", "<leader>w", "<cmd>w<CR>", { desc = "general save file" })

-- Quit
map("n", "<leader>q", "<cmd>q<CR>", { desc = "quit"})

-- Explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "toggle nvimtree" })

-- whichkey
map("n", "<leader>kK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map("n", "<leader>kk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- Debugger
map("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>")
map("n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>")
map("n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>")
map("n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>")
map("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<CR>", { desc = "Toggle DAP UI"})
