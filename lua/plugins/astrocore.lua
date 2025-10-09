-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
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
      relativenumber = false,
      clipboard = "unnamedplus",
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
        --guifont = "JetBrainsMono Nerd Font:h10",
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
        neovide_scroll_animation_length = 0.15,
        neovide_hide_mouse_when_typing = true,
        neovide_scroll_animation_far_lines = 1,
        neovide_cursor_hack = true,
        neovide_font_edging = "subpixelantialiased",
        neovide_font_hinting = "slight",
        neovide_text_gamma = 0.8,
        neovide_text_contrast = 0.4,

        --   neovide_cursor_vfx_mode = "ripple",
        --   neovide_cursor_vfx_opacity = 200,
        --   neovide_cursor_vfx_particle_lifetime = 1.0,
        --   neovide_cursor_vfx_particle_density = 7.0,
        --   neovide_cursor_vfx_particle_speed = 10.0,
        --   neovide_cursor_vfx_particle_color = "#91c5e4ff",
        --   neovide_cursor_vfx_particle_shape = "line",
        go_to_relative_line = function(num) -- maybe add str for reasons like: goto d = next douplicate?
          local win = vim.api.nvim_get_current_win() --vim.api.nvim_input(
          vim.api.nvim_win_set_cursor(win, { vim.api.nvim_win_get_cursor(win)[1] + num, 0 })
        end,

        jump_word_e = function(v) -- meh
          local col = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[2]
          vim.api.nvim_input(
            (vim.api.nvim_get_current_line():sub(col + 1, col + 1) == "." and "<right>" or "")
              .. (v and "" or "<C-o>")
              .. "e<right>"
          )
        end,

        jump_word_b = function(v) -- meh v.2 | Added: repeating code, lol | Better than having multiple local variables and an if statment
          local col = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[2]
          vim.api.nvim_input(
            (vim.api.nvim_get_current_line():sub(col, col) == "." and "<left>" or "") .. (v and "" or "<C-o>") .. "b"
          )
        end, -- TODO: make it work in visual mode

        paste_check = function()
          local clipboard = vim.fn.getreg "+"
          if string.find(clipboard, "\n") then -- that find, meh..
            local win = vim.api.nvim_get_current_win()
            local pos = vim.api.nvim_win_get_cursor(win) --vim.api.nvim_buf_set_lines(0, pos[1], pos[1], false, {''})
            vim.api.nvim_command "pu" -- TODO: 'u' only if not line.trim is nothing| https://stackoverflow.com/a/1346747/11465149
            vim.api.nvim_win_set_cursor(win, { pos[1] + 1, pos[2] })
            return "" --clipboard:sub(0,-2)
          end
          return clipboard
        end,

        paste_on_visual = function() print "test v paste" end,

        toggle_strict_mode = function() -- eew!
          local c
          if _G["__strict_toggle"] then
            _G["__strict_toggle"] = false
            for i = 32, 126, 1 do
              c = string.char(i)
              vim.keymap.set("v", c, '"_di' .. c)
            end
            vim.keymap.set("v", "<CR>", '"_di<CR>')
            print "Strict mode enabled"
          else
            _G["__strict_toggle"] = true
            for i = 32, 126, 1 do
              c = string.char(i)
              vim.keymap.del("v", c)
            end
            vim.keymap.del("v", "<CR>")
            print "Strict mode disabled"
          end
        end,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- Normal mode mappings
      n = {
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
        -- load projects
        ["<leader>dh"] = { "<cmd>Dashboard<cr>", desc = "Open Dashboard" },
        -- Save and quit
        ["<C-s>"] = { ":w!<CR>", desc = "Save file", silent = true },

        -- Move lines up/down
        ["<A-j>"] = { ":m+<CR>==", desc = "Move line down", silent = true },
        ["<A-down>"] = { ":m+<CR>==", desc = "Move line down", silent = true },
        ["<A-k>"] = { ":m-2<CR>==", desc = "Move line up", silent = true },
        ["<A-up>"] = { ":m-2<CR>==", desc = "Move line up", silent = true },

        -- Word movement
        ["<C-right>"] = { "e", desc = "Jump to end of word", silent = true },
        ["<C-left>"] = { "b", desc = "Jump to beginning of word", silent = true },

        -- File explorer
        ["<C-b>"] = { ":Neotree toggle<cr>", desc = "Toggle file explorer", silent = true },

        -- Toggle strict mode
        ["<A-m>"] = { ":call toggle_strict_mode()<cr>", desc = "Toggle strict mode", silent = true },

        -- LSP and mouse mappings
        ["<C-LeftMouse>"] = { "<LeftMouse>:lua vim.lsp.buf.definition()<CR>", desc = "Go to definition", silent = true },

        -- Change list navigation
        ["<A-left>"] = { "g;", desc = "Previous change", silent = true },
        ["<A-right>"] = { "g,", desc = "Next change", silent = true },

        -- Clear search highlight
        ["<esc>"] = { ":noh<cr>", desc = "Clear search highlight", silent = true },
      },

      -- Insert mode mappings
      i = {
        -- Multi-cursor support
        ["<C-A-up>"] = { "<ESC>:call vm#commands#add_cursor_up(0,1)<CR>", desc = "Add cursor up", silent = true },
        ["<C-A-down>"] = { "<ESC>:call vm#commands#add_cursor_down(0,1)<CR>", desc = "Add cursor down", silent = true },

        -- Tab indentation
        ["<S-Tab>"] = { "<ESC>v<<ESC>i<right>", desc = "Unindent line", silent = true },

        -- Save and quit
        ["<C-s>"] = { "<C-o>:w!<CR>", desc = "Save file", silent = true },
        ["<C-q>"] = { "<C-o>:q!<CR>", desc = "Quit without saving", silent = true },

        -- Move lines up/down
        ["<A-j>"] = { "<Esc>:m+<CR>==gi", desc = "Move line down", silent = true },
        ["<A-down>"] = { "<Esc>:m+<CR>==gi", desc = "Move line down", silent = true },
        ["<A-k>"] = { "<Esc>:m-2<CR>==gi", desc = "Move line up", silent = true },
        ["<A-up>"] = { "<Esc>:m-2<CR>==gi", desc = "Move line up", silent = true },

        -- Word movement
        ["<C-right>"] = { "<C-o>:call jump_word_e()<CR>", desc = "Jump to end of word", silent = true },
        ["<C-left>"] = { "<C-o>:call jump_word_b()<CR>", desc = "Jump to beginning of word", silent = true },

        -- Copy/Cut/Paste
        ["<C-c>"] = { "<C-o>yy", desc = "Copy line", silent = true },
        ["<C-v>"] = { "<C-r>=paste_check()<CR>", desc = "Paste", silent = true },
        ["<C-x>"] = { "<C-o>dd", desc = "Cut line", silent = true },

        -- Scroll
        ["<C-Up>"] = { "<C-o><C-y>", desc = "Scroll up", silent = true },
        ["<C-Down>"] = { "<C-o><C-e>", desc = "Scroll down", silent = true },

        -- Block selection
        ["<C-a>"] = { "<Esc>ggVG", desc = "Select all", silent = true },
        ["<C-S-Up>"] = { "<C-o><C-v>k", desc = "Block select up", silent = true },
        ["<C-S-Down>"] = { "<C-o><C-v>j", desc = "Block select down", silent = true },
        ["<F8>"] = { "<C-o><C-v>k", desc = "Block select up (fallback)", silent = true },
        ["<F6>"] = { "<C-o><C-v>j", desc = "Block select down (fallback)", silent = true },

        -- New line
        ["<A-M>"] = { "<C-o>o", desc = "New line below", silent = true },
        ["<C-cr>"] = { "<C-o>o", desc = "New line below", silent = true },
        ["<F9>"] = { "<C-o>o", desc = "New line below (fallback)", silent = true },

        -- Text selection with Shift+Arrow
        ["<S-Up>"] = { function() vim.cmd "normal! ggVG" end, desc = "Select up", silent = true },
        ["<S-Down>"] = { "<C-o>vj", desc = "Select down", silent = true },
        ["<S-left>"] = { "<left><C-o>v", desc = "Select left", silent = true },
        ["<S-right>"] = { "<C-o>v", desc = "Select right", silent = true },
        ["<C-S-left>"] = { "<left><C-o>vb", desc = "Select word left", silent = true },
        ["<C-S-right>"] = { "<C-o>vw", desc = "Select word right", silent = true },

        -- Comment toggle
        ["<C-_>"] = { "<C-o>:Commentary<cr>", desc = "Toggle comment (Windows)", silent = true },
        ["<C-/>"] = { "<C-o>:Commentary<cr>", desc = "Toggle comment", silent = true },

        -- File explorer
        ["<C-b>"] = { "<ESC>:Neotree toggle<cr>", desc = "Toggle file explorer", silent = true },

        -- Undo/Redo
        ["<C-z>"] = { "<C-o>u", desc = "Undo", silent = true },
        ["<C-r>"] = { "<C-o>:redo<cr>", desc = "Redo", silent = true },
        ["<C-S-z>"] = { "<C-o>:redo<cr>", desc = "Redo", silent = true },
        ["<F10>"] = { "<C-o>:redo<cr>", desc = "Redo (fallback)", silent = true },

        -- Delete word backward
        ["<C-BS>"] = { '<esc><right>"_dbi', desc = "Delete word backward", silent = true },
        ["<C-h>"] = { '<esc><right>"_dbi', desc = "Delete word backward", silent = true },

        -- Terminal toggle
        ["<C-j>"] = { "<esc>:ToggleTerm direction=horizontal<cr>", desc = "Toggle terminal", silent = true },

        -- Multi-cursor find
        ["<C-d>"] = { "<esc><right>:call vm#commands#ctrln(1)<cr>", desc = "Multi-cursor find next", silent = true },

        -- Delete line
        ["<F4>"] = { '<C-o>"_dd', desc = "Delete line (Windows fallback)", silent = true },
        ["<C-S-k>"] = { '<C-o>"_dd', desc = "Delete line", silent = true },
        -- Toggle strict mode and go to relative line
        ["<A-m>"] = { "<C-o>:call toggle_strict_mode()<cr>", desc = "Toggle strict mode", silent = true },
        ["<C-g>"] = { "<C-o>:call go_to_relative_line()<left>", desc = "Go to relative line", silent = true },

        -- LSP go to definition
        ["<F12>"] = { vim.lsp.buf.definition, desc = "Go to definition", silent = true },

        -- Mouse mappings
        ["<RightMouse>"] = { "<C-o>p", desc = "Paste at mouse", silent = true },
        ["<ScrollWheelUp>"] = { "<C-o>4<C-Y>", desc = "Scroll up (mouse)", silent = true },
        ["<ScrollWheelDown>"] = { "<C-o>4<C-E>", desc = "Scroll down (mouse)", silent = true },
        ["<C-LeftMouse>"] = {
          "<LeftMouse><C-o>:lua vim.lsp.buf.definition()<CR>",
          desc = "Go to definition (mouse)",
          silent = true,
        },

        -- Search
        ["<C-f>"] = { "<esc>:let mode=1<cr>/", desc = "Search", silent = true },

        -- Change list navigation
        ["<A-left>"] = { "<C-o>g;", desc = "Previous change", silent = true },
        ["<A-right>"] = { "<C-o>g,", desc = "Next change", silent = true },
      },

      -- Visual mode mappings
      v = {
        -- Tab indentation
        ["<Tab>"] = { ">gv", desc = "Indent selection", silent = true },
        ["<S-Tab>"] = { "<gv", desc = "Unindent selection", silent = true },

        -- Save and quit
        ["<C-q>"] = { ":q!<CR>", desc = "Quit without saving", silent = true },

        -- Move lines up/down
        ["<A-j>"] = { ":m'>+<CR>gv=gv", desc = "Move selection down", silent = true },
        ["<A-down>"] = { ":m'>+<CR>gv=gv", desc = "Move selection down", silent = true },
        ["<A-k>"] = { ":m-2<CR>gv=gv", desc = "Move selection up", silent = true },
        ["<A-up>"] = { ":m-2<CR>gv=gv", desc = "Move selection up", silent = true },

        -- Copy/Cut/Paste
        ["<C-c>"] = { "ygv", desc = "Copy selection", silent = true },
        ["<C-v>"] = { '"_dgP', desc = "Paste over selection", silent = true },
        ["<C-x>"] = { "di", desc = "Cut selection", silent = true },

        -- Visual mode behavior
        ["<BS>"] = { '"_di', desc = "Delete selection", silent = true },
        ["<left>"] = { "O<ESC>i", desc = "Move to start of selection", silent = true },
        ["<right>"] = { "<ESC>i<right>", desc = "Move to end of selection", silent = true },
        ["<up>"] = { "<ESC><up>i", desc = "Move up and enter insert", silent = true },
        ["<down>"] = { "<ESC><down>i", desc = "Move down and enter insert", silent = true },
        ["<S-right>"] = { "l", desc = "Extend selection right", silent = true },
        ["<S-left>"] = { "h", desc = "Extend selection left", silent = true },
        ["<S-up>"] = { "k", desc = "Extend selection up", silent = true },
        ["<S-down>"] = { "j", desc = "Extend selection down", silent = true },

        -- Comment toggle
        ["<C-_>"] = { ":Commentary<cr>", desc = "Toggle comment (Windows)", silent = true },
        ["<C-/>"] = { ":Commentary<cr>", desc = "Toggle comment", silent = true },

        -- Undo
        ["<C-z>"] = { "<ESC>ui", desc = "Undo and return to insert", silent = true },

        -- New line
        ["<C-cr>"] = { "<ESC>o", desc = "New line below", silent = true },
        ["<F9>"] = { "<ESC>o", desc = "New line below (fallback)", silent = true },

        -- Mouse mappings
        -- ["<RightMouse>"] = { "yi", desc = "Copy selection", silent = true },
      },
    },
  },
}
