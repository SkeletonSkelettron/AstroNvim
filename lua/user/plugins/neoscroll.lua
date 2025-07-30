-- ~/.config/nvim/lua/user/plugins/neoscroll.lua
return {
  "karb94/neoscroll.nvim",
  opts = {
    -- Customize mappings and options here
    -- These are the default mappings that neoscroll will animate:
    mappings = {
      "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb",
    },
    hide_cursor = true,         -- Hide cursor while scrolling
    stop_eof = true,            -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,  -- Whether to respect 'scrolloff' (usually best to leave false with neoscroll)

    -- Optional: Change the default easing function for a smoother start/end
    easing = "quadratic", -- Other options: "linear", "cubic", "quartic", "quintic", "circular", "sine"

    -- Optional: Customize duration for specific mappings
    -- You can define custom mappings with specific durations/easing here
    -- For example, to make <C-d> scroll with sine easing and 250ms duration:
    -- ["<C-d>"] = function() require("neoscroll").ctrl_d({ duration = 250, easing = "sine" }) end,
  },
  -- If you want to customize specific keybindings or more advanced setups,
  -- you can use the 'keys' table or a 'config' function here.
  -- Example of custom keybindings that call neoscroll functions:
  -- keys = {
  --   { "<C-u>", function() require("neoscroll").scroll("-vim.wo.scroll", true, 250) end, mode = { "n", "v" }, desc = "Scroll half page up (smooth)" },
  --   { "<C-d>", function() require("neoscroll").scroll("vim.wo.scroll", true, 250) end, mode = { "n", "v" }, desc = "Scroll half page down (smooth)" },
  -- },
}