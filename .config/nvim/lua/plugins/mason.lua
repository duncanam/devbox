return {
  {
    "williamboman/mason.nvim",
    config = function ()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function ()
      require("mason-lspconfig").setup {
        -- TODO: make this a variable such that the docker process can pre-install these in the container
        ensure_installed = { "rust_analyzer" },
      }
    end
  },
}
