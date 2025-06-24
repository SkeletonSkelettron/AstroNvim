-- ~/.config/nvim/lua/user/plugins/configs/nvim-dap.lua

-- Import the nvim-dap module
local dap = require "dap"

-- Check if nvim-dap is loaded. If not, don't try to configure.
if not dap then return end

-----------------------------------------------------------------------
-- C/C++ Debugging with CodeLLDB
-- Requires 'codelldb' to be installed on your system.
-- AstroNvim usually prompts for this, or you can install it manually.
-- Example installation for CodeLLDB:
--   mkdir -p ~/.config/nvim/bin
--   cd ~/.config/nvim/bin
--   wget https://github.com/vadimcn/vscode-lldb/releases/download/v1.10.0/codelldb-x86_64-linux.vsix # Linux
--   # or wget for macOS: https://github.com/vadimcn/vscode-lldb/releases/download/v1.10.0/codelldb-x86_64-darwin.vsix
--   unzip codelldb-x86_64-linux.vsix # or darwin.vsix
--   mv extension/adapter/codelldb .
--   mv extension/lldb/liblldb.so . # or .dylib for macOS
-----------------------------------------------------------------------

-- Define the 'cppdbg' adapter for nvim-dap
dap.adapters.cppdbg = {
  type = "executable",
  -- *** IMPORTANT: Adjust this path to where your 'codelldb' executable is! ***
  -- This is a common location if you installed it via the AstroNvim prompt.
  command = vim.fn.stdpath "data" .. "/mason/bin/codelldb", -- Default Mason path
  -- Or if you installed manually to ~/.config/nvim/bin:
  -- command = vim.fn.stdpath("config") .. "/bin/codelldb",
  args = { "--port", "56789" },
}

-- Define debug configurations for C++ files
dap.configurations.cpp = {
  {
    name = "Launch Current File (GDB/LLDB)",
    type = "cppdbg",
    request = "launch",
    program = function()
      -- Prompt for the executable path, defaulting to a.out in the current directory
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/a.out", "file")
    end,
    cwd = "${workspaceFolder}", -- Start in the workspace folder
    stopOnEntry = true, -- Pause at the start of the program
    setupCommands = { -- GDB/LLDB specific setup
      {
        text = "-enable-pretty-printing", -- Enable pretty-printing for C++ data structures
        description = "enable pretty printing",
        ignoreFailures = false,
      },
    },
  },
  -- You can add more configurations here, e.g., for attaching to a process, etc.
  -- {
  --   name = "Attach to Process (GDB/LLDB)",
  --   type = "cppdbg",
  --   request = "attach",
  --   processId = function()
  --     return tonumber(vim.fn.input("Process ID: "))
  --   end,
  --   cwd = "${workspaceFolder}",
  -- },
}

-----------------------------------------------------------------------
-- You can add configurations for other languages here if needed.
-- Example Python (requires debugpy: pip install debugpy)
-----------------------------------------------------------------------
-- dap.adapters.python = {
--   type = "executable",
--   command = "python", -- Or the full path to your python executable (e.g., in a venv)
--   args = { "-m", "debugpy.adapter" },
-- }

-- dap.configurations.python = {
--   {
--     type = "python",
--     request = "launch",
--     name = "Launch Python File",
--     program = "${file}", -- Debug the current file
--     pythonPath = function()
--       -- This tries to find python in your current virtual environment or default to system python
--       local venv = os.getenv("VIRTUAL_ENV")
--       if venv then
--         return venv .. "/bin/python"
--       end
--       return "python"
--     end,
--   },
-- }

-- You might also want to setup some UI for DAP, if not already configured by AstroNvim
-- require("nvim-dap-ui").setup({})
-- require("nvim-dap-virtual-text").setup()
