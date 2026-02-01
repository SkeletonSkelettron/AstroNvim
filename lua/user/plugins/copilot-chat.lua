-- ~/.config/nvim/lua/user/plugins/copilot-chat.lua
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary", -- Use the canary branch for the latest features
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua for the official Copilot plugin
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
      { "nvim-telescope/telescope.nvim" }, -- (Optional) For picker integrations
    },
    build = "make tiktoken", -- Only on MacOS or Linux, helps with token counting
    history_path = vim.fn.stdpath "data" .. "/copilot-chat",
    opts = {
      -- Configuration options go here (see below for examples)
      -- mode = "split", -- newbuffer or split, default: newbuffer
      prompts = {
        Explain = "Explain how it works.",
        Tests = "Briefly explain how the selected code works, then generate unit tests.",
      },
      auto_insert_mode = true,
      window = {
        width = 0.4,
      },
      context = "git",
      -- etc.
      mappings = {
        -- This is the "Edit" key. It applies the suggestion to your file.GPT-5.1-Codex-Max
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        -- Show the diff before applying (optional safety check)
        show_diff = {
          normal = "gd",
        },
      },
    },
    keys = {
      -- Example keybindings (you can customize these)
      {
        "<C-i>",
        'copilot#Accept("<CR>")',
        mode = "i",
        expr = true,
        replace_keycodes = false,
        desc = "Copilot - Accept suggestion",
      },
      { "<leader>-ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>-ct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
      { "<leader>-cr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
      { "<leader>-cp", "<cmd>CopilotChatPrompts<cr>", desc = "CopilotChat - Prompt" },
      { "<leader>-ca", "<cmd>CopilotChatAgents<cr>", desc = "CopilotChat - Agents" },
      { "<leader>-cm", "<cmd>CopilotChatModels<cr>", desc = "CopilotChat - Models" },
      {
        "<leader>-cq",
        function()
          local input = vim.fn.input "Ask Copilot: "
          if input ~= "" then vim.cmd("CopilotChat " .. input) end
        end,
        desc = "CopilotChat - Ask input",
      },
      { "<leader>-cT", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle chat window" },
      {
        "<leader>-cE", -- "Copilot Edit"
        ":CopilotChatEdit ", -- Note the trailing space
        mode = "v",
        desc = "Copilot Chat Edit Selection",
      },
      {
        "<leader>-cI",
        function()
          local input = vim.fn.input "Quick Edit: "
          if input ~= "" then
            require("CopilotChat").ask(input) -- No options passed
          end
        end,
        mode = "v",
        desc = "Inline Edit",
      },
      -- More keybindings are available in the plugin's documentation
    },
  },
}
