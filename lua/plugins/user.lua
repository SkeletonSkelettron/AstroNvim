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
    "karb94/neoscroll.nvim",
    opts = {
      -- Default options (you can adjust these)
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop scrolling at EOF (end of file)
      respect_scrolloff = false, -- Respect 'scrolloff' option
      easing_function = nil, -- Custom easing function, or nil for default
    },
    config = function(_, opts)
      require("neoscroll").setup(opts)

      -- Set up the key mappings with correct syntax
      local neoscroll = require "neoscroll"

      -- Define custom key mappings
      local keymap = {
        -- Standard scrolling motions
        ["<C-u>"] = function() neoscroll.ctrl_u { duration = 250 } end,
        ["<C-d>"] = function() neoscroll.ctrl_d { duration = 250 } end,
        ["<C-b>"] = function() neoscroll.ctrl_b { duration = 450 } end,
        ["<C-f>"] = function() neoscroll.ctrl_f { duration = 450 } end,

        -- Custom arrow key mappings
        ["<C-Down>"] = function() neoscroll.scroll(2, true, 100) end,
        ["<C-Up>"] = function() neoscroll.scroll(-2, true, 100) end,

        -- Mouse wheel scrolling
        -- ["<ScrollWheelUp>"] = function() neoscroll.scroll(-3, true, 50) end,
        -- ["<ScrollWheelDown>"] = function() neoscroll.scroll(3, true, 50) end,

        -- Line by line scrolling (uncomment if you want smooth j/k)
        -- ["j"] = function() neoscroll.scroll(1, true, 50) end,
        -- ["k"] = function() neoscroll.scroll(-1, true, 50) end,
      }

      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },
 

  {
    "neovim/nvim-lspconfig",
    ---@param opts lspconfig.options
    opts = {
      -- Configure server setup to use your custom clangd configuration
      servers = {
        -- Remove clangd from here since we're using custom setup
        -- clangd = {},  -- Remove this line
      },
    },
    config = function(plugin, opts)
      -- First, run the default AstroNvim lspconfig setup
      require "astronvim.plugins.configs.lspconfig"(plugin, opts)

      -- Then load your custom clangd configuration
      local clangd_config = require "user.plugins.clangd"
      if clangd_config and clangd_config.clangd then
        -- Execute your custom clangd setup function
        clangd_config.clangd()
      end
    end,
  },
  {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("jb").setup { transparent = true }
      -- vim.cmd "colorscheme jb"
    end,
  },
{
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = true }, -- You might disable these if using nvim-cmp
      panel = { enabled = true },      -- or if CopilotChat.nvim handles the UI
    })
  end,
},
  {
    "folke/lazy.nvim", -- We leverage lazy.nvim's 'config' for general settings
    opts = {
      init = function()
        -- Your existing global Neovim options would be here, like:
        -- vim.opt.number = true
      end,
    },
  },
--   {
--     "lukas-reineke/indent-blankline.nvim",
--     enabled = true,
--     main = "ibl",
--     ---@module "ibl"
--     ---@type ibl.config
--     opts = {
--       indent = {
--         char = "", -- Change character
--         highlight = "Comment", -- Make them dimmer
--       },
--       scope = {
--         enabled = false, -- Disable scope highlighting
--       },
--     },
--   },
  {
    "akinsho/toggleterm.nvim",
    version = "*", -- Use the latest stable release
    cmd = "ToggleTerm", -- Makes the plugin available via :ToggleTerm command
    config = function()
      require("toggleterm").setup {
        -- Your configuration options go here
        -- For example:
        size = 20,
        open_mapping = [[<c-\>]], -- Default mapping, you can change this
        direction = "float", -- or "horizontal", "vertical"
        -- and many more options: shade_filetypes, start_in_insert, etc.
      }
    end,
    keys = {
      -- Example keybinding: <leader>t to toggle the terminal
      { "<leader>t", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      -- Example for floating terminal
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
      -- Example for horizontal terminal
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle horizontal terminal" },
      -- Example for vertical terminal
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle vertical terminal" },
      -- You can also specify specific terminal types:
      { "<leader>tn", function() require("toggleterm").toggle(1) end, desc = "Toggle Node.js terminal" },
      { "<leader>tg", function() require("toggleterm").toggle(2) end, desc = "Toggle Git terminal" },
    },
  },
  
}
