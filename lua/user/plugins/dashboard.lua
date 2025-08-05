-- ~/.config/nvim/lua/user/plugins/dashboard.lua
return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup {
      theme = "hyper",
      config = {
        header = {
          "",
          "  █████╗ ███████╗████████╗██████╗  ██████╗ ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
          " ██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔═══██╗████╗  ██║██║   ██║██║████╗ ████║",
          " ███████║███████╗   ██║   ██████╔╝██║   ██║██╔██╗ ██║██║   ██║██║██╔████╔██║",
          " ██╔══██║╚════██║   ██║   ██╔══██╗██║   ██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
          " ██║  ██║███████║   ██║   ██║  ██║╚██████╔╝██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
          " ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
          "",
        },
        project = {
          enable = true,
          limit = 8,
          icon = "󰏓 ",
          label = " Recent Projects:",
          action = "Neotree",
        },
        week_header = {
          enable = false,
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = " Apps",
            group = "DiagnosticHint",
            action = "Telescope app",
            key = "a",
          },
          {
            desc = " dotfiles",
            group = "Number",
            action = "Telescope dotfiles",
            key = "d",
          },
          {
            icon = "󰈔",
            desc = " Open existing project",
            action = function()
              -- Use the file_browser extension for hierarchical navigation
              require("telescope").extensions.file_browser.file_browser {
                cwd = "~/Projects", -- The directory to start Browse from
                prompt_title = "Browse Projects",
              }
            end,
            key = "o",
          },
        },
      },
    }
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
