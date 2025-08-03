-- ~/.config/nvim/lua/user/plugins/neoscroll.lua
return 
  {

    "karb94/neoscroll.nvim",
    opts = {
      -- Default options (you can adjust these)
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop scrolling at EOF (end of file)
      respect_scrolloff = false, -- Respect 'scrolloff' option
      easing_function = nil, -- Custom easing function, or nil for default
    },
    config = function(_, opts)
      require("neoscroll").setup(opts)

      -- Set up the key mappings with correct syntax
      local neoscroll = require "neoscroll"

      -- Define custom key mappings
      local keymap = {
        -- Standard scrolling motions
        ["<C-u>"] = function() neoscroll.ctrl_u { duration = 250 } end,
        ["<C-d>"] = function() neoscroll.ctrl_d { duration = 250 } end,
        ["<C-b>"] = function() neoscroll.ctrl_b { duration = 450 } end,
        ["<C-f>"] = function() neoscroll.ctrl_f { duration = 450 } end,

        -- Custom arrow key mappings
        ["<C-Down>"] = function() neoscroll.scroll(2, true, 100) end,
        ["<C-Up>"] = function() neoscroll.scroll(-2, true, 100) end,

        -- Mouse wheel scrolling
        ["<ScrollWheelUp>"] = function() neoscroll.scroll(-25, true, 300) end,
        ["<ScrollWheelDown>"] = function() neoscroll.scroll(25, true, 300) end,

        -- Line by line scrolling (uncomment if you want smooth j/k)
        ["j"] = function() neoscroll.scroll(1, true, 300) end,
        ["k"] = function() neoscroll.scroll(-1, true, 300) end,
      }

      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  }

  --{
--   "karb94/neoscroll.nvim",
--   event = "VeryLazy",
--   config = function()
--     require('neoscroll').setup({
--       mappings = {
--         "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb",
--       },
--       hide_cursor = true,
--       stop_eof = true,
--       respect_scrolloff = false,
--       cursor_scrolls_alone = true,
--       easing_function = "sine",
--       performance_mode = false,
--     })

--     -- local neoscroll = require('neoscroll')
    
--     vim.keymap.set({'n', 'v', 'x'}, '<ScrollWheelUp>', function()
--       neoscroll.ctrl_u({ duration = 500, easing = "sine" })
--     end)
    
--     vim.keymap.set({'n', 'v', 'x'}, '<ScrollWheelDown>', function()
--       neoscroll.ctrl_d({ duration = 500, easing = "sine" })
--     end)
--   end
-- }
