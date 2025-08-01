-- ~/.config/nvim/lua/user/plugins/neoscroll.lua
return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    require('neoscroll').setup({
      mappings = {
        "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb",
      },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing_function = "sine",
      performance_mode = false,
    })

    -- local neoscroll = require('neoscroll')
    
    -- vim.keymap.set({'n', 'v', 'x'}, '<ScrollWheelUp>', function()
    --   neoscroll.ctrl_u({ duration = 500, easing = "sine" })
    -- end)
    
    -- vim.keymap.set({'n', 'v', 'x'}, '<ScrollWheelDown>', function()
    --   neoscroll.ctrl_d({ duration = 500, easing = "sine" })
    -- end)
  end
}