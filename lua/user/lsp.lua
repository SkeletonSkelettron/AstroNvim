return {
  -- Add more servers here as needed
  servers = {
    clangd = {
      cmd = { "clangd", "--background-index" }, -- optional custom args
      filetypes = { "c", "cpp", "cxx", "h", "hpp", "hxx", "objc", "objcpp" },
    },
    angularls = {
        -- Make sure it attaches to the correct filetypes
        filetypes = {
          "typescript",
          "html",
          "typescriptreact",
          "typescript.tsx",
          "html.angular",
          "htmlangular",
        },
        -- Define root patterns for Angular projects
        root_dir = require("lspconfig.util").root_pattern("angular.json", "project.json"),
        -- Optional: You can add an on_attach here if you need specific angularls client capabilities
        -- For most cases, AstroLSP's default on_attach should be sufficient.
        -- on_attach = function(client, bufnr)
        --     -- You might want to disable certain angularls capabilities if they conflict
        --     -- For example, some users disable renameProvider to avoid duplicate renames.
        --     -- client.server_capabilities.renameProvider = false
        --     require("astrolsp").on_attach(client, bufnr) -- Call AstroLSP's default on_attach
        -- end,
    },
    ts_ls = {
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
        -- You can add more tsserver settings here if needed
      },
    lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- prevent warning about 'vim' global
            },
            workspace = {
              checkThirdParty = false, -- disable telemetry warning
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
              },
            },
          },
        },
    },
  },
}

