return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = { enabled = true },
        panel = { enabled = true },
        server_opts_overrides = {
          settings = {
            advanced = {
              model = "claude-4.5-opus",
            },
          },
        },
      }
    end,
  },
}
