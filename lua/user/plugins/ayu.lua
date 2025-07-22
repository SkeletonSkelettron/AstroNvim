-- ~/.config/nvim/lua/user/plugins/ayu.lua

---@type LazySpec
return {
  "ayu-theme/ayu-vim",
  lazy = false, -- Load immediately on startup
  priority = 1000, -- Give it a high priority
  config = function()
    -- You can set global variables here if the theme requires it
    -- For ayu-vim, setting the background to 'light' is often key
    vim.o.background = "light"
    vim.g.ayu_colorscheme = "light" -- Some variants use this
    -- If you want specifically 'ayu_light' (often the default light), you might not need ayu_colorscheme

    -- Other options you might find in ayu-vim's documentation:
    -- vim.g.ayu_italic = 1 -- Enable italic for comments etc.
    -- vim.g.ayu_true_colors = 1 -- For true color terminals

    -- No explicit `require("ayu").setup()` for this one usually,
    -- you just load it and set options via vim.g
  end,
}
