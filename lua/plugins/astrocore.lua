-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly reco:mmend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        foo = "fooscript",
      },
      filename = {
        [".foorc"] = "fooscript",
      },
      pattern = {
        [".*/etc/foo/.*"] = "fooscript",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        mouse = "a",
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        guifont = "JetBrainsMono Nerd Font:h10.5",
        -- You might also want to set linespace for better visual spacing
        linespace = 0,
      },
        g = {
          -- Neovide specific global variables
          neovide_opacity = 1.0, -- Example: slightly transparent
          neovide_scale_factor = 1.0,
          neovide_remember_window_size = true,
          neovide_confirm_quit = true,
          neovide_cursor_animation_length = 0.02,
          neovide_scroll_animation_length = 0.6,
          neovide_hide_mouse_when_typing = true,
          neovide_scroll_animation_far_lines = 1,
          neovide_cursor_hack = true,
          neovide_font_edging = "subpixelantialiased",
          neovide_font_hinting = "full",
          neovide_text_gamma = 0.8,
          neovide_text_contrast = 0.2,
        --   neovide_cursor_vfx_mode = "ripple",
        --   neovide_cursor_vfx_opacity = 200,
        --   neovide_cursor_vfx_particle_lifetime = 1.0,
        --   neovide_cursor_vfx_particle_density = 7.0,
        --   neovide_cursor_vfx_particle_speed = 10.0,
        --   neovide_cursor_vfx_particle_color = "#91c5e4ff",
        --   neovide_cursor_vfx_particle_shape = "line",
        },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
