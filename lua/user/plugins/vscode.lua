-- ~/.config/nvim/lua/user/plugins/vscode.lua

return {
  "Mofiqul/vscode.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Set the colorscheme immediately after the plugin is loaded
    -- vim.cmd.colorscheme "vscode"
    -- vim.o.background = "light"
  end,
}
