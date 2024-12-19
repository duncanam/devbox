return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour="mocha"
    },
    config = function ()
      vim.cmd.colorscheme "catppuccin"
      -- TODO: this is not working
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg='#969ed3' , bold=true})
    end,
  },
}
