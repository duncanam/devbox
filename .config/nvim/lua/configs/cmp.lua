local config = require "nvchad.configs.cmp"
local cmp = require("cmp")

config.mapping["<Up>"] = cmp.mapping.select_prev_item()
config.mapping["<Down>"] = cmp.mapping.select_next_item()

return config
