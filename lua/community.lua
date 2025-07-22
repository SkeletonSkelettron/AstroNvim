-- ~/.config/nvim/lua/community.lua

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.recipes.picker-nvchad-theme" },
  { import = "user.plugins.onenord" },
  { import = "user.plugins.neogit" },
  { import = "user.plugins.vim-flog" },
  { import = "user.plugins.gitsigns" },
  --{ import = "astrocommunity.editing-support.copilotchat-nvim" },
}
