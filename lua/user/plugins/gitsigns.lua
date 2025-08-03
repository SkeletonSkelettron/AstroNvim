-- ~/.config/nvim/lua/user/plugins/gitsigns.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- ... other gitsigns opts ...
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      local gs = require "gitsigns"
      local map = vim.keymap.set
      local bufopts = { silent = true, buffer = vim.api.nvim_get_current_buf() }

      -- Example blame mapping:
      map("n", "<leader>gb", function() gs.blame_line { full = false } end, bufopts)
      map("n", "<leader>gB", function() gs.blame_line { full = true } end, bufopts)
      -- ... other gitsigns mappings (e.g., ]h, [h for hunks)
    end,
  },
  -- ... rest of your plugins ...
}
