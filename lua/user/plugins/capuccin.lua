-- ~/.config/nvim/lua/user/plugins/capuccin.lua

---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin", -- Important for setting the colorscheme by its name later
  lazy = false, -- Load immediately on startup
  priority = 1000, -- Give it a high priority
  config = function()
    require("catppuccin").setup {
      flavour = "latte", -- This is the light variant of Catppuccin
      -- Other optional settings you can customize:
      transparent_background = false, -- Set to true if you want a transparent background
      term_colors = true, -- Set terminal colors (useful if your terminal supports it)
      styles = { -- Style specific elements
        comments = { "italic" },
        conditionals = { "bold" },
        loops = { "italic" },
        functions = { "bold" },
        keywords = { "bold" },
        strings = { "italic" },
        variables = { "bold" },
        numbers = { "italic" },
        booleans = { "bold" },
        properties = { "italic" },
        type = { "bold" },
        operators = { "italic" },
      },
      integrations = { -- Integrate with other plugins (if you use them)
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        mini = true,
        which_key = true,
        -- Add more integrations as needed
      },
    }
  end,
}
