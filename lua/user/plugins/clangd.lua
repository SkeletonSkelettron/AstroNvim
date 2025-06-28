return {
  -- Skip Mason installation for clangd
  ["clangd"] = function()
    local lspconfig = require "lspconfig"
    local astrolsp = require "astrolsp"
    lspconfig.clangd.setup {
      -- Use system clangd instead of Mason-installed one
      cmd = { "clangd" }, -- This will use system PATH clangd

      -- Optional: specify full path if needed
      -- cmd = { "/usr/bin/clangd" },

      capabilities = require("astrolsp").config.capabilities,
      on_attach = function(client, bufnr)
        -- Call the default AstroLSP on_attach
        astrolsp.config.on_attach(client, bufnr)

        -- Ensure key mappings are set up
        local map = vim.keymap.set
        local opts = { buffer = bufnr, silent = true }

        -- Function navigation mappings
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "gt", vim.lsp.buf.type_definition, opts)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
      end,

      -- clangd specific settings
      init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true,
      },

      -- Additional clangd arguments
      cmd_env = {
        -- Ensure clangd finds compile_commands.json
        CLANGD_FLAGS = "--compile-commands-dir=.",
      },

      settings = {
        clangd = {
          -- Enable all clangd features
          InlayHints = {
            Designators = true,
            Enabled = true,
            ParameterNames = true,
            DeducedTypes = true,
          },
          fallbackFlags = { "-std=c++17" },
        },
      },
    }
  end,
}
