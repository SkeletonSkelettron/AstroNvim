-- ~/.config/nvim/lua/user/plugins/onenord.lua

---@type LazySpec
return {
  "rmehri01/onenord.nvim",
  lazy = false, -- Load immediately on startup
  priority = 1000, -- Give it a high priority
  config = function()
    require("onenord").setup {
      theme = "light",
      borders = true, -- Split window borders
      fade_nc = false, -- Fade non-current windows
      styles = {
        comments = "NONE", -- No specific style, just color
        strings = "NONE",
        keywords = "bold",
        functions = "bold",
        variables = "NONE",
        diagnostics = "underline",
      },
      custom_highlights = {
        -- Variable field access (variable->field, variable.field)
        ["VariableField"] = { fg = "#0018BD" },

        -- Boolean values (true, false)
        ["Boolean"] = { fg = "#0000FF" }, -- Base boolean group
        ["@boolean"] = { fg = "#0000FF" }, -- Tree-sitter booleans
        ["@constant.builtin.boolean"] = { fg = "#0000FF" }, -- Tree-sitter boolean constants
        ["cppBoolean"] = { fg = "#0000FF" }, -- C++ boolean values

        -- Boolean type (bool)
        ["Type"] = { fg = "#0000FF" }, -- Base type group
        ["@type"] = { fg = "#0000FF" }, -- Tree-sitter types
        ["StorageClass"] = { fg = "#0000FF" }, -- Storage class specifiers

        -- FIX: "if" should not be bold - need to specify color AND bold = false
        ["Conditional"] = { fg = "#AF00DB", bold = false },
        ["@keyword.conditional"] = { fg = "#AF00DB", bold = false },
        ["cConditional"] = { fg = "#AF00DB", bold = false },

        ["@lsp.typemod.function.globalScope.cpp"] = { fg = "#BA7E25", bold = false },
        ["@lsp.type.function.cpp"] = { fg = "#BA7E25", bold = false },
        ["@lsp.typemod.function.defaultLibrary.cpp"] = { fg = "#BA7E25", bold = false },
        ["@lsp.typemod.class.defaultLibrary.cpp"] = { fg = "#3879c5", bold = false },
        ["@lsp.typemod.class.globalScope.cpp"] = { fg = "#3879c5", bold = false },
        ["@lsp.mod.globalScope.cpp"] = { fg = "#3879c5", bold = false },
        ["@lsp.typemod.method.defaultLibrary.cpp"] = { fg = "#BA7E25", bold = false },
        ["@function.method"] = { fg = "#BA7E25", bold = false },
        ["@lsp.typemod.method.readonly.cpp"] = { fg = "#BA7E25", bold = false },
        ["@lsp.typemod.method.classScope.cpp"] = { fg = "#BA7E25", bold = false },
        ["@lsp.type.method.cpp"] = { fg = "#BA7E25", bold = false },

        ["@constructor"] = { fg = "#0000FF" },
        ["Number"] = { fg = "#0000FF" },
        ["@number"] = { fg = "#0000FF" },
        ["@type.builtin"] = { fg = "#0000FF" },
        ["@lsp.typemod.type.defaultLibrary.cpp"] = { fg = "#0000FF", bold = false },
        ["@lsp.mod.defaultLibrary.cpp"] = { fg = "#267F99", bold = false },
        ["@lsp.type.variable.cpp"] = { fg = "#0018BD", bold = false },

        -- C++ property/field access highlighting
        ["@property"] = { fg = "#0018BD", bold = false },

        ["@lsp.type.property.cpp"] = { fg = "#0018BD", bold = false },
        ["@lsp.mod.classScope.cpp"] = { fg = "#0018BD", bold = false },
        ["@lsp.typemod.property.classScope.cpp"] = { fg = "#0018BD" },
        ["@lsp.typemod.property.defaultLibrary.cpp"] = { fg = "#0018BD" },
        ["cppString"] = { bold = false },
        ["cType"] = { fg = "#0000FF", bold = false },

        -- CORRECT comment highlight groups
        ["Comment"] = { fg = "#006100" }, -- Base comment group
        ["@comment"] = { fg = "#006100" }, -- Tree-sitter comments
        ["cCommentL"] = { fg = "#006100" }, -- C line comments
        ["cComment"] = { fg = "#006100" }, -- C block comments
        ["@comment.line"] = { fg = "#006100" }, -- Tree-sitter line comments
        ["@comment.block"] = { fg = "#006100" }, -- Tree-sitter block comments

        -- Add these for #include preprocessing directives
        ["PreProc"] = { fg = "#AF00DB" }, -- Base preprocessor group
        ["@preproc"] = { fg = "#AF00DB" }, -- Tree-sitter preprocessor
        ["cInclude"] = { fg = "#AF00DB" }, -- C #include specifically
        ["@keyword.directive"] = { fg = "#AF00DB" }, -- Tree-sitter directive keywords
        ["@keyword.import"] = { fg = "#AF00DB" }, -- Tree-sitter import keywords
        ["cPreCondit"] = { fg = "#AF00DB" },

        -- "for" loop keyword - be specific
        ["@keyword.repeat"] = { fg = "#AF00DB" }, -- Tree-sitter loop keywords (for, while, etc.)
        ["cRepeat"] = { fg = "#AF00DB" }, -- C repeat statements
        ["Repeat"] = { fg = "#AF00DB" }, -- Vim's repeat keyword group

        -- angular
        ["IlluminatedWordText"] = { fg = "#0000FF", bold = false },
        ["@lsp.typemod.property.declaration.typescript"] = { bold = false },
        ["@lsp.mod.declaration.typescript"] = { bold = false },
        ["@lsp.type.property.typescript"] = { bold = false },
        ["@lsp.type.member.typescript"] = { bold = false },
        ["typescriptAsyncFuncKeyword"] = { bold = false },
        ["@lsp.typemod.member.declaration.typescript"] = { bold = false },
        ["@lsp.type.function.typescript"] = { bold = false },
        ["typescriptAccessibilityModifier"] = { bold = false },
        ["typescriptClassBlock"] = { bold = false },
        ["typescriptMember"] = { bold = false },
        ["TSProperty"] = { bold = false },
        ["TSField"] = { bold = false },
        ["LspVariable"] = { bold = false },
      },
      vim.cmd.colorscheme "onenord",
    }

    -- Force the highlight after theme loads
    vim.schedule(function()
      vim.api.nvim_set_hl(0, "@keyword.conditional", { fg = "#AF00DB", bold = false })
      vim.api.nvim_set_hl(0, "Conditional", { fg = "#AF00DB", bold = false })
      vim.api.nvim_set_hl(0, "cConditional", { fg = "#AF00DB", bold = false })

      -- Force LSP property highlights
      vim.api.nvim_set_hl(0, "@property", { fg = "#0018BD" })
      vim.api.nvim_set_hl(0, "@lsp.type.property.cpp", { fg = "#0018BD" })
      vim.api.nvim_set_hl(0, "@lsp.mod.classScope.cpp", { fg = "#0018BD" })
      vim.api.nvim_set_hl(0, "@lsp.typemod.property.classScope.cpp", { fg = "#0018BD" })
      vim.api.nvim_set_hl(0, "@lsp.typemod.property.defaultLibrary.cpp", { fg = "#0018BD" })
    end)
  end,
}
