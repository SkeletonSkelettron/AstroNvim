-- ~/.config/nvim/lua/user/plugins/nvim-scrollview.lua

return {
  {
    "dstein64/nvim-scrollview",
    opts = {
      -- You can customize its appearance and behavior here
      -- For example, to make it always visible:
      always_on = true,
      excluded_filetypes = {'nerdtree'},
      signs_on_startup = {'all'},
      width = 1,
      character = '│',   
      highlight = 'ScrollView',
    },
    config = function(_, opts)
      require("scrollview").setup(opts)
    end,
  },
}