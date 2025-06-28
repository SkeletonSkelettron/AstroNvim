-- ~/.config/nvim/lua/community.lua

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.recipes.picker-nvchad-theme" },
  --{ import = "astrocommunity.workflow.copilot-chat-nvim" },
  -- import/override with your plugins folder
}
