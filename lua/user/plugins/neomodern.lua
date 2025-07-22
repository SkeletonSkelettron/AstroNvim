-- ~/.config/nvim/lua/user/plugins/neomodern.lua

---@type LazySpec
return {
  "cdmill/neomodern.nvim",
  lazy = false, -- Load immediately on startup
  priority = 1000, -- Give it a high priority to ensure it loads before other UI elements
  config = function()
    require("neomodern").setup {
      -- Set your preferred theme variant and color
      theme = "gyokuro", -- Or "iceclimber", "hojicha", "roseprime"
      variant = "light", -- VERY IMPORTANT: Specify 'light' for a light theme
      -- You can customize other options here if you want:
      -- transparent = false,
      -- styles = {
      --   comments = { "italic" },
      --   keywords = { "bold" },
      -- },
      -- highlights = {
      --   Comment = { fg = "#666666" },
      -- },
    }
  end,
}
