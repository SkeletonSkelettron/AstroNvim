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
  { import = "user.plugins.copilot-chat" },
  { import = "user.plugins.nvim-scrollview" },
  { import = "user.plugins.neoscroll" },
  { import = "user.plugins.telescope" },
  { import = "user.plugins.vim-commentary" },
  { import = "user.plugins.vscode" },
  { import = "user.plugins.dashboard" },
  { import = "user.plugins.trouble" },
  { import = "user.plugins.overseer" },
  { import = "user.plugins.telescope-file-browser" },
  { import = "user.plugins.nvim-dap-virtual-text" },
  { import = "user.plugins.avante" },
  --{ import = "astrocommunity.editing-support.copilotchat-nvim" },
}
