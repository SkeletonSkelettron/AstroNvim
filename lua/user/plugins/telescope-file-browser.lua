-- ~/.config/nvim/lua/user/plugins/telescope-file-browser.lua
--
return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function() require("telescope").load_extension "file_browser" end,
}
