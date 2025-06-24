-- ~/.config/nvim/lua/user/highlights.lua

return function()
  -- Get the currently active colorscheme
  local current_colorscheme = vim.o.colorscheme

  -- Define your desired number color for a specific theme
  local number_color_for_my_theme = "#87D7FF" -- Example: Red

  -- Check if the current colorscheme matches your specific theme
  -- Replace "your_specific_theme_name" with the actual name of your theme (e.g., "catppuccin", "ayu", "onenord")
  if current_colorscheme == "your_specific_theme_name" then
    vim.api.nvim_set_hl(0, "Number", { fg = number_color_for_my_theme, bg = "NONE", bold = true, italic = false })
  end

  -- You can add more conditional overrides for other themes or highlight groups here:
  -- if current_colorscheme == "another_theme_name" then
  --   vim.api.nvim_set_hl(0, "Number", { fg = "#0000FF" }) -- Example: Blue numbers for another theme
  -- end

  -- Always add general overrides for elements that might not be themed by colorschemes
  -- or if you want consistent looks across themes
  -- For example, setting the background of the Telescope floating window
  -- vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "NONE", bg = "NONE" })
end
