-- ~/.config/nvim/lua/user/plugins/overseer/template/user/cmake.lua

local overseer = require("overseer")

return {
  -- CMake Configure (Ninja)
  {
    name = "cmake configure ninja",
    builder = function()
      return {
        cmd = { "cmake" },
        args = { 
          "-S", ".", 
          "-B", "build",
          "-GNinja",
          "-DCMAKE_BUILD_TYPE=Debug",
          "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
        },
        cwd = vim.fn.getcwd(),
        components = {
          { "on_output_quickfix", open = true },
          "default",
        },
      }
    end,
    condition = {
      filetype = { "cmake" },
      callback = function()
        return vim.fn.filereadable("CMakeLists.txt") == 1 and vim.fn.executable("ninja") == 1
      end,
    },
  },

  -- CMake Configure Release (Ninja)
  {
    name = "cmake configure ninja release",
    builder = function()
      return {
        cmd = { "cmake" },
        args = { 
          "-S", ".", 
          "-B", "build",
          "-GNinja",
          "-DCMAKE_BUILD_TYPE=Release",
          "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
        },
        cwd = vim.fn.getcwd(),
        components = {
          { "on_output_quickfix", open = true },
          "default",
        },
      }
    end,
    condition = {
      filetype = { "cmake" },
      callback = function()
        return vim.fn.filereadable("CMakeLists.txt") == 1 and vim.fn.executable("ninja") == 1
      end,
    },
  },

  -- Ninja Build (Fast parallel build)
  {
    name = "ninja build",
    builder = function()
      return {
        cmd = { "ninja" },
        args = { 
          "-C", "build",
          "-j", tostring(vim.loop.os_nproc())
        },
        cwd = vim.fn.getcwd(),
        components = {
          { "on_output_quickfix", open = true },
          "default",
        },
      }
    end,
    condition = {
      filetype = { "cmake", "cpp", "c" },
      callback = function()
        return vim.fn.filereadable("build/build.ninja") == 1
      end,
    },
  },

  -- Ninja Build Specific Target
  {
    name = "ninja build target",
    builder = function()
      local target = vim.fn.input("Target name: ", "")
      if target == "" then
        target = "all"
      end
      
      return {
        cmd = { "ninja" },
        args = { 
          "-C", "build",
          "-j", tostring(vim.loop.os_nproc()),
          target
        },
        cwd = vim.fn.getcwd(),
        components = {
          { "on_output_quickfix", open = true },
          "default",
        },
      }
    end,
    condition = {
      filetype = { "cmake", "cpp", "c" },
      callback = function()
        return vim.fn.filereadable("build/build.ninja") == 1
      end,
    },
  },

  -- Ninja Clean
  {
    name = "ninja clean",
    builder = function()
      return {
        cmd = { "ninja" },
        args = { "-C", "build", "clean" },
        cwd = vim.fn.getcwd(),
        components = {
          { "on_output_quickfix", open = true },
          "default",
        },
      }
    end,
    condition = {
      filetype = { "cmake", "cpp", "c" },
      callback = function()
        return vim.fn.filereadable("build/build.ninja") == 1
      end,
    },
  },

  -- CMake Install (via Ninja)
  {
    name = "ninja install",
    builder = function()
      return {
        cmd = { "ninja" },
        args = { "-C", "build", "install" },
        cwd = vim.fn.getcwd(),
        components = {
          { "on_output_quickfix", open = true },
          "default",
        },
      }
    end,
    condition = {
      filetype = { "cmake", "cpp", "c" },
      callback = function()
        return vim.fn.filereadable("build/build.ninja") == 1
      end,
    },
  },

  -- Run executable (assumes single target)
  {
    name = "cmake run",
    builder = function()
      -- Try to find executable in build directory
      local build_dir = "build"
      local executables = {}
      
      -- Common executable locations
      local possible_paths = {
        build_dir,
        build_dir .. "/bin",
        build_dir .. "/Debug",
        build_dir .. "/Release",
      }
      
      for _, path in ipairs(possible_paths) do
        if vim.fn.isdirectory(path) == 1 then
          local files = vim.fn.glob(path .. "/*", false, true)
          for _, file in ipairs(files) do
            if vim.fn.executable(file) == 1 and not file:match("%.") then
              table.insert(executables, file)
            end
          end
        end
      end
      
      local exe_path = ""
      if #executables > 0 then
        exe_path = executables[1] -- Use first found executable
      else
        -- Fallback: ask user
        exe_path = vim.fn.input("Executable path: ", build_dir .. "/")
      end
      
      return {
        cmd = { exe_path },
        args = {},
        cwd = vim.fn.getcwd(),
        components = {
          { "on_output_quickfix", open = true },
          "default",
        },
      }
    end,
    condition = {
      filetype = { "cmake", "cpp", "c" },
      callback = function()
        return vim.fn.filereadable("build/build.ninja") == 1
      end,
    },
  },

  -- CMake Test (CTest)
  {
    name = "cmake test",
    builder = function()
      return {
        cmd = { "ctest" },
        args = { 
          "--test-dir", "build",
          "--output-on-failure",
          "--verbose"
        },
        cwd = vim.fn.getcwd(),
        components = {
          { "on_output_quickfix", open = true },
          "default",
        },
      }
    end,
    condition = {
      filetype = { "cmake", "cpp", "c" },
      callback = function()
        return vim.fn.filereadable("build/CTestTestfile.cmake") == 1
      end,
    },
  },
}