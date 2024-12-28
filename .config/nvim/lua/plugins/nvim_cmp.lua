 return {
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  -- Completion Icons
  "onsails/lspkind.nvim",

  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          -- Seems odd that I have to require this twice
          format = require("lspkind").cmp_format({
             mode = "symbol_text",
             -- This disables extraneous info
             -- https://github.com/hrsh7th/nvim-cmp/issues/1154#issuecomment-1242914151
             menu = {},
           }),
        },
        mapping = cmp.mapping.preset.insert({
           ["<CR>"] = cmp.mapping.confirm({select = false})
         }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end
  },
}
