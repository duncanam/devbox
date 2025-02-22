return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Set VeryLazy to allow for faster initial leader response
 {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },

  -- Override default ensure_installed
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
       "html", "css", "rust", "python"
  		},
  	},
  },

  {
    "lewis6991/spaceless.nvim",
    lazy = false,
  },
}
