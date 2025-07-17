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
    "lewis6991/gitsigns.nvim",
    -- Optional: Add configuration for gitsigns.nvim here
    -- This 'opts' table will be passed to require("gitsigns").setup()
    opts = {
      -- Customize keymaps (optional)
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "✖" },
        topdelete = { text = "⇧" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        -- Keymaps for Gitsigns actions (optional, but recommended)
        local gs = require "gitsigns"
        local map = vim.keymap.set
        local bufopts = { silent = true, buffer = bufnr }

        map("n", "]h", function() gs.nav_hunk "next" end, bufopts)
        map("n", "[h", function() gs.nav_hunk "prev" end, bufopts)
        map("n", "<leader>hs", gs.stage_hunk, bufopts)
        map("n", "<leader>hr", gs.reset_hunk, bufopts)
        map("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end, bufopts)
        map("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end, bufopts)
        map("n", "<leader>hS", gs.stage_buffer, bufopts)
        map("n", "<leader>hu", gs.reset_hunk, { vim.fn.line ".", vim.fn.line "v" })
        map("n", "<leader>hR", gs.reset_buffer, bufopts)
        map("n", "<leader>hp", gs.preview_hunk, bufopts)
        map("n", "<leader>hb", function() gs.blame_line { full = true } end, bufopts)
        map("n", "<leader>hd", gs.diffthis, bufopts)
        map("n", "<leader>hD", function() gs.diffthis "~" end, bufopts)
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", bufopts)
      end,
    },
    -- The 'config' function runs the setup
    config = function(_, opts) require("gitsigns").setup(opts) end,
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
  -- {
  --   "3rd/image.nvim",
  --   opts = {
  --     backend = "kitty", -- or "ueberzug" for Linux
  --     integrations = {
  --       markdown = {
  --         enabled = true,
  --         clear_in_insert_mode = false,
  --         download_remote_images = true,
  --         only_render_image_at_cursor = false,
  --         filetypes = { "markdown", "vimwiki" },
  --       },
  --     },
  --   },
  -- },
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
    "wfxr/minimap.vim",
    -- Recommended settings to start with
    config = function()
      -- Set the default width of the minimap (e.g., 10 characters)
      vim.g.minimap_width = 10
      -- Hide the minimap by default on startup
      vim.g.minimap_auto_start = 0
      -- Do not show it in terminals
      vim.g.minimap_excluded_filetypes = { "NvimTree", "lazy", "TelescopePrompt", "Trouble", "terminal" }
      -- Optional: Smooth scrolling of the minimap (requires 'nvim-tree.lua' setup or similar if not there)
      -- vim.g.minimap_smooth_scroll = 1

      -- Optional: Keymaps to toggle or interact with the minimap
      -- You can add these to your 'user/keymaps.lua' or inside this config function
      vim.cmd [[
        nnoremap <leader>mm :MinimapToggle<CR>
        nnoremap <leader>mo :MinimapOpen<CR>
        nnoremap <leader>mc :MinimapClose<CR>
      ]]
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
  --
  {
    "rmehri01/onenord.nvim",
    lazy = false, -- Load immediately on startup
    priority = 1000, -- Give it a high priority
    config = function()
      require("onenord").setup {
        theme = "light",
        borders = true, -- Split window borders
        fade_nc = false, -- Fade non-current windows
        styles = {
          comments = "NONE", -- No specific style, just color
          strings = "NONE",
          keywords = "bold",
          functions = "bold",
          variables = "NONE",
          diagnostics = "underline",
        },
        custom_highlights = {
          -- Variable field access (variable->field, variable.field)
          ["VariableField"] = { fg = "#001080" },

          -- Boolean values (true, false)
          ["Boolean"] = { fg = "#0000FF" }, -- Base boolean group
          ["@boolean"] = { fg = "#0000FF" }, -- Tree-sitter booleans
          ["@constant.builtin.boolean"] = { fg = "#0000FF" }, -- Tree-sitter boolean constants
          ["cppBoolean"] = { fg = "#0000FF" }, -- C++ boolean values

          -- Boolean type (bool)
          ["Type"] = { fg = "#0000FF" }, -- Base type group
          ["@type"] = { fg = "#0000FF" }, -- Tree-sitter types
          ["StorageClass"] = { fg = "#0000FF" }, -- Storage class specifiers

          -- FIX: "if" should not be bold - need to specify color AND bold = false
          ["Conditional"] = { fg = "#AF00DB", bold = false },
          ["@keyword.conditional"] = { fg = "#AF00DB", bold = false },
          ["cConditional"] = { fg = "#AF00DB", bold = false },

          ["@lsp.typemod.function.globalScope.cpp"] = { fg = "#74531f", bold = false },
          ["@lsp.type.function.cpp"] = { fg = "#74531f", bold = false },
          ["@lsp.typemod.function.defaultLibrary.cpp"] = { fg = "#74531f", bold = false },
          ["@lsp.typemod.class.defaultLibrary.cpp"] = { fg = "#3879c5", bold = false },
          ["@lsp.typemod.class.globalScope.cpp"] = { fg = "#3879c5", bold = false },
          ["@lsp.mod.globalScope.cpp"] = { fg = "#3879c5", bold = false },
          ["@lsp.typemod.method.defaultLibrary.cpp"] = { fg = "#74531f", bold = false },
          ["@function.method"] = { fg = "#74531f", bold = false },
          ["@lsp.typemod.method.readonly.cpp"] = { fg = "#74531f", bold = false },
          ["@lsp.typemod.method.classScope.cpp"] = { fg = "#74531f", bold = false },
          ["@lsp.type.method.cpp"] = { fg = "#74531f", bold = false },

          ["@constructor"] = { fg = "#0000FF" },
          ["Number"] = { fg = "#0000FF" },
          ["@number"] = { fg = "#0000FF" },
          ["@type.builtin"] = { fg = "#0000FF" },
          ["@lsp.typemod.type.defaultLibrary.cpp"] = { fg = "#0000FF", bold = false },
          ["@lsp.mod.defaultLibrary.cpp"] = { fg = "#267F99", bold = false },
          ["@lsp.type.variable.cpp"] = { fg = "#001080", bold = false },

          -- C++ property/field access highlighting
          ["@property"] = { fg = "#001080", bold = false },

          ["@lsp.type.property.cpp"] = { fg = "#001080", bold = false },
          ["@lsp.mod.classScope.cpp"] = { fg = "#001080", bold = false },
          ["@lsp.typemod.property.classScope.cpp"] = { fg = "#001080" },
          ["@lsp.typemod.property.defaultLibrary.cpp"] = { fg = "#001080" },
          ["cppString"] = { fg = "#A31515", bold = false },
          ["cType"] = { fg = "#0000FF", bold = false },

          -- CORRECT comment highlight groups
          ["Comment"] = { fg = "#008000" }, -- Base comment group
          ["@comment"] = { fg = "#008000" }, -- Tree-sitter comments
          ["cCommentL"] = { fg = "#008000" }, -- C line comments
          ["cComment"] = { fg = "#008000" }, -- C block comments
          ["@comment.line"] = { fg = "#008000" }, -- Tree-sitter line comments
          ["@comment.block"] = { fg = "#008000" }, -- Tree-sitter block comments

          -- Add these for #include preprocessing directives
          ["PreProc"] = { fg = "#AF00DB" }, -- Base preprocessor group
          ["@preproc"] = { fg = "#AF00DB" }, -- Tree-sitter preprocessor
          ["cInclude"] = { fg = "#AF00DB" }, -- C #include specifically
          ["@keyword.directive"] = { fg = "#AF00DB" }, -- Tree-sitter directive keywords
          ["@keyword.import"] = { fg = "#AF00DB" }, -- Tree-sitter import keywords
          ["cPreCondit"] = { fg = "#AF00DB" },

          -- "for" loop keyword - be specific
          ["@keyword.repeat"] = { fg = "#AF00DB" }, -- Tree-sitter loop keywords (for, while, etc.)
          ["cRepeat"] = { fg = "#AF00DB" }, -- C repeat statements
          ["Repeat"] = { fg = "#AF00DB" }, -- Vim's repeat keyword group

          -- angular
          ["IlluminatedWordText"] = { fg = "#0000FF", bold = false },
          ["@lsp.typemod.property.declaration.typescript"] = { bold = false },
          ["@lsp.mod.declaration.typescript"] = { bold = false },
          ["@lsp.type.property.typescript"] = { bold = false },
        },
      }

      -- Force the highlight after theme loads
      vim.schedule(function()
        vim.api.nvim_set_hl(0, "@keyword.conditional", { fg = "#AF00DB", bold = false })
        vim.api.nvim_set_hl(0, "Conditional", { fg = "#AF00DB", bold = false })
        vim.api.nvim_set_hl(0, "cConditional", { fg = "#AF00DB", bold = false })

        -- Force LSP property highlights
        vim.api.nvim_set_hl(0, "@property", { fg = "#001080" })
        vim.api.nvim_set_hl(0, "@lsp.type.property.cpp", { fg = "#001080" })
        vim.api.nvim_set_hl(0, "@lsp.mod.classScope.cpp", { fg = "#001080" })
        vim.api.nvim_set_hl(0, "@lsp.typemod.property.classScope.cpp", { fg = "#001080" })
        vim.api.nvim_set_hl(0, "@lsp.typemod.property.defaultLibrary.cpp", { fg = "#001080" })
      end)
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
  -- GitHub Copilot plugin
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth", -- Automatically run :Copilot auth on first install
    event = "BufReadPost",
    opts = {
      suggestion = { enabled = false }, -- Disable Copilot's own inline suggestions
      panel = { enabled = false }, -- Disable Copilot's own suggestion panel
    },
  },

  -- Integration for nvim-cmp with Copilot
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" }, -- Ensure copilot.lua is loaded first
    config = function() require("copilot_cmp").setup {} end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      if opts.sources == nil then opts.sources = {} end

      table.insert(opts.sources, 1, {
        name = "copilot",
        group_index = 1,
        priority = 100,
      })
      -- Also include the <Tab> keybinding configuration from step 3 above if desired.
      -- opts.mapping["<Tab>"] = cmp.mapping(function(fallback) ... end)
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      -- { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "folke/lazy.nvim", -- We leverage lazy.nvim's 'config' for general settings
    opts = {
      init = function()
        -- Your existing global Neovim options would be here, like:
        -- vim.opt.number = true
        vim.opt.relativenumber = false
        -- vim.opt.tabstop = 4
        -- ...

        -- Add the clipboard setting here
        vim.opt.clipboard = "unnamedplus"
        -- Your existing global keymaps might also be here, like:
        -- vim.g.mapleader = ' '
        -- vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = "Save File" })
      end,
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    opts = {
      indent = {
        char = "", -- Change character
        highlight = "Comment", -- Make them dimmer
      },
      scope = {
        enabled = false, -- Disable scope highlighting
      },
    },
  },
}
