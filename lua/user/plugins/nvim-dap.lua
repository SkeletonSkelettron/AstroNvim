-- ~/.config/nvim/lua/user/plugins/nvim-dap.lua

-- Import the nvim-dap module
local dap = require "dap"

-- Check if nvim-dap is loaded. If not, don't try to configure.
if not dap then return end

dap.adapters.codelldb = {
  type = "server",
  port = "1234",
  executable = {
    command = vim.fn.exepath "codelldb",
    args = { "--port", "1234" },
  },
}

-- Define debug configurations for C++ files
dap.configurations.cpp = {
  {
    name = "Launch current file(codelldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      local function get_cmake_target()
        local cmake_file = vim.fn.getcwd() .. "/CMakeLists.txt"
        if vim.fn.filereadable(cmake_file) == 1 then
          local content = vim.fn.readfile(cmake_file)
          for _, line in ipairs(content) do
            local target = line:match "add_executable%s*%(%s*([%w_%-]+)"
            if target then return target end
          end
        end
        return nil
      end

      local target = get_cmake_target()
      local default_path = vim.fn.getcwd() .. "/build/" .. (target or "")
      return vim.fn.input("Path to executable: ", default_path, "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
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
