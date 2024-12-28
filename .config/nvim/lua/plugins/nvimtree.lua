local left_right_border = 30
local top_bottom_border = 10

local start_col = (math.floor(left_right_border / 2) - 1)
local start_row = math.floor(top_bottom_border / 2)

return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function ()
      require("nvim-tree").setup({
        view = {
          float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = {
              relative = "editor",
              border = "rounded",
              width = (vim.fn.winwidth(0) - left_right_border),
              height = (vim.fn.winheight(0) - top_bottom_border),
              col = start_col,
              row = start_row,
            },
          }
        }
      })
    end
  }
}
