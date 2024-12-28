return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        {
          { "<leader>f", group = "file" }, -- group
          { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
          { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep", mode = "n" },
          { "<leader>fn", desc = "New File" },
          { "<leader>W", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
          { "<leader>c", "<cmd>bd<cr>", desc = "Close Buffer" },
          { "<leader>b", group = "buffers", expand = function()
              return require("which-key.extras").expand.buf()
            end
          },
          {
            -- Nested mappings are allowed and can be added in any order
            -- Most attributes can be inherited or overridden on any level
            -- There's no limit to the depth of nesting
            mode = { "n", "v" }, -- NORMAL and VISUAL mode
            { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
            { "<leader>w", "<cmd>w<cr>", desc = "Write" },
          },
          { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File Explorer", mode = "n" },
        }
      }
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
