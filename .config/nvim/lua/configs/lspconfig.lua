-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

lspconfig.ruff.setup{}
lspconfig.pyright.setup{}
