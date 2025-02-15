require "nvchad.options"

-- Used by Docker to install Mason plugins during docker build
vim.api.nvim_create_user_command("MasonInstallAll", function ()
  -- TODO: this should be only defined once, yet it's also in the plugin file mason.lua
  vim.cmd("MasonInstall " .. table.concat({ "rust-analyzer" }, " "))
end, {})

-- Cursorline
local o = vim.o
o.cursorlineopt ='both'

-- Relative line numbers
vim.o.number = true          -- Enable absolute line numbers
vim.o.relativenumber = true  -- Enable relative line numbers
vim.o.scrolloff = 999        -- Keep centered
vim.api.nvim_create_autocmd("InsertEnter", { command = [[set norelativenumber]] })
vim.api.nvim_create_autocmd("InsertLeave", { command = [[set relativenumber]] })
