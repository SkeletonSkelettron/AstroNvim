-- ~/.config/nvim/lua/user/plugins/overseer/overseer.lua

return {
  {
    'stevearc/overseer.nvim',
    opts = {
      templates = { "builtin", "user.cmake" },
      strategy = {
        "toggleterm",
        direction = "horizontal",
        autos_croll = true,
        quit_on_exit = "success"
      },
      component_aliases = {
        default = {
          { "display_duration", detail_level = 2 },
          "on_output_summarize",
          "on_exit_set_status",
          { "on_complete_notify", statuses = { "FAILURE" } },
          "on_complete_dispose",
        },
      },
    },
    cmd = { "OverseerRun", "OverseerToggle", "OverseerInfo" },
    keys = {
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run Overseer task" },
      { "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
    },
  },
}