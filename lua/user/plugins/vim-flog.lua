-- ~/.config/nvim/lua/user/plugins/vim-flog.lua

return   {
    "rbong/vim-flog",
    -- Flog usually wants to be loaded eagerly if you map commands for it
    dependencies = {
      "tpope/vim-fugitive", -- Explicitly list the dependency
      -- You can also use AstroNvim's community import if you removed the above line:
      -- { import = "astrocommunity.git.vim-fugitive" },
    },
    lazy = false,
    -- Or use event = "CmdlineEnter" if you want it to load when you type commands
    -- or event = "BufReadPost"
    -- However, for immediate availability of :Flog, lazy=false is easiest.
    config = function()
      -- Optional: Custom Flog settings (refer to :h flog-settings)
      -- For example, to change default window types:
      vim.g.flog_default_group_window = "vnew" -- Open branches/tags in vsplit by default
      vim.g.flog_default_commit_window = "tabnew" -- Open commits in new tab by default

      -- You don't usually call a setup() function for vim-flog.
      -- It works mostly through global variables and its commands.
    end,
    -- You can define keymaps directly here
    keys = {
        { "<leader>gL", "<cmd>Flogsplit<CR>", desc = "Flog (Git Log Split)" }, -- Clear for Flog
        { "<leader>gg", "<cmd>Flog<CR>", desc = "Flog (Git Log Current)" },    -- New distinct mapping
    },
}