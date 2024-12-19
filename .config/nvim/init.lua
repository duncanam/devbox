-- disable netrw at the very start of your init.lua
-- Required by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Suggested by nvim-tree
vim.opt.termguicolors = true

-- Relative line numbers
vim.o.number = true          -- Enable absolute line numbers
vim.o.relativenumber = true  -- Enable relative line numbers
vim.o.scrolloff = 999        -- Keep centered
vim.api.nvim_create_autocmd("InsertEnter", { command = [[set norelativenumber]] })
vim.api.nvim_create_autocmd("InsertLeave", { command = [[set relativenumber]] })

-- Plugins
require("config.lazy")

--vim.api.nvim_create_user_command("MasonInstallAll", function ()
--  vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
--end, {})

-- Colorscheme
--vim.api.nvim_set_hl(0, 'CursorLineNr', { fg='#969ed3' , bold=true})

vim.api.nvim_set_hl(0, 'CursorLineNr', { fg='#969ed3' , bold=true})
