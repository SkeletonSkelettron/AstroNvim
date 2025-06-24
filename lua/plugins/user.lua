--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
    event = "BufReadPost", -- Or "VeryLazy"
    config = function()
      require("diffview").setup {
        -- Your diffview.nvim configuration options can go here
        -- Example: To set default layout or other preferences
        -- view = {
        --   default = {
        --     layout = "diff2_vertical", -- 'diff2_horizontal', 'diff3_vertical', 'diff3_horizontal'
        --   },
        -- },
        -- file_panel = {
        --   win_config = {
        --     position = "left", -- 'left', 'right'
        --     width = 30,
        --   },
        -- },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() end
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfusssenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
    ensure_installed = {
      "codelldb", -- For C/C++ (if you want to keep it)
    },
  },
  {
    "mfussenegger/nvim-dap",
    -- Add other DAP-related dependencies here if they are not already managed by AstroNvim's core
    -- AstroNvim usually handles these, but if you want to be explicit:
    dependencies = {
      "rcarriga/nvim-dap-ui", -- For better UI
      "theHamsta/nvim-dap-virtual-text", -- For inline variable previews
      -- Add language specific adapters if not already provided by AstroNvim's default setup
      -- "williamboman/mason-nvim-dap", -- For installing debug adapters via Mason
    },
    -- This 'config' function tells AstroNvim to load your custom nvim-dap.lua
    -- after the plugin itself is set up.
    config = function()
      print ">>> DEBUG: nvim-dap config function is running! <<<"
      -- Load your custom nvim-dap configuration
      require "user.plugins.nvim-dap"
      require("dap").set_log_level "TRACE"
      --require("dap").set(vim.fn.expand "~/dap_debug.log")
    end,
  },
  {
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
  },
  {
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
  },
  {
    "ayu-theme/ayu-vim",
    lazy = false, -- Load immediately on startup
    priority = 1000, -- Give it a high priority
    config = function()
      -- You can set global variables here if the theme requires it
      -- For ayu-vim, setting the background to 'light' is often key
      vim.o.background = "light"
      vim.g.ayu_colorscheme = "light" -- Some variants use this
      -- If you want specifically 'ayu_light' (often the default light), you might not need ayu_colorscheme

      -- Other options you might find in ayu-vim's documentation:
      -- vim.g.ayu_italic = 1 -- Enable italic for comments etc.
      -- vim.g.ayu_true_colors = 1 -- For true color terminals

      -- No explicit `require("ayu").setup()` for this one usually,
      -- you just load it and set options via vim.g
    end,
  },
  -- {
  --   "projekt0n/github-nvim-theme",
  --   lazy = false, -- Load immediately on startup
  --   priority = 1000, -- Give it a high priority
  --   config = function()
  --     require("github-theme").setup {
  --       theme_style = "light", -- Crucial: Set to "light" for GitHub Light
  --       transparent = false,
  --       hide_inactive_statusline = false,
  --       function_style = "italic",
  --       comment_style = "italic",
  --       keyword_style = "bold",
  --       variable_style = "bold",
  --       -- You can explore more options in the plugin's documentation
  --       -- like integrations with other plugins (nvim-tree, cmp, etc.)
  --       -- Check https://github.com/projekt0n/github-nvim-theme
  --     }
  --   end,
  -- },
  {
    "rmehri01/onenord.nvim",
    lazy = false, -- Load immediately on startup
    priority = 1000, -- Give it a high priority
    config = function()
      require("onenord").setup {
        -- Set to "light" for the light variant
        theme = "light",
        -- Alternatively, you could rely on vim.o.background:
        -- theme = nil, -- remove this option
        -- vim.o.background = "light", -- set this globally in your user/init.lua or here

        borders = true, -- Split window borders
        fade_nc = false, -- Fade non-current windows

        -- Example styles (customize as you like):
        styles = {
          comments = "NONE", -- No specific style, just color
          strings = "NONE",
          keywords = "bold",
          functions = "bold",
          variables = "NONE",
          diagnostics = "underline",
        },
        custom_highlights = {
          ["@constructor"] = { fg = "#0000FF" },
          ["Number"] = { fg = "#0000FF" },
        },

        -- You can explore more options in the plugin's documentation
        -- like custom_highlights or integrations with other plugins (lualine, etc.)
        -- Check https://github.com/rmehri01/onenord.nvim
      }
    end,
  },
  {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      -- require("jb").setup({transparent = true})
      vim.cmd "colorscheme jb"
    end,
  },
}
