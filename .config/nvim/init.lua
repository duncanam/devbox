-- disable netrw at the very start of your init.lua
-- Required by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Suggested by nvim-tree and bufferline
vim.opt.termguicolors = true

-- Relative line numbers
vim.o.number = true          -- Enable absolute line numbers
vim.o.relativenumber = true  -- Enable relative line numbers
vim.o.scrolloff = 999        -- Keep centered
vim.api.nvim_create_autocmd("InsertEnter", { command = [[set norelativenumber]] })
vim.api.nvim_create_autocmd("InsertLeave", { command = [[set relativenumber]] })

-- Plugins
require("config.lazy")

-- Used by Docker to install Mason plugins during docker build
vim.api.nvim_create_user_command("MasonInstallAll", function ()
  -- TODO: this should be only defined once, yet it's also in the plugin file mason.lua
  vim.cmd("MasonInstall " .. table.concat({ "rust-analyzer" }, " "))
end, {})

-- Highlight cursorline and line number
vim.opt.cursorline = true

-- Buffer (Tab) Switching
vim.api.nvim_set_keymap("n", "<S-Right>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Left>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
