-- ~/.config/nvim/lua/user/plugins/onenord.lua

---@type LazySpec
return {
  "rmehri01/onenord.nvim",
  lazy = false, -- Load immediately on startup
  priority = 1000, -- Give it a high priority
  config = function()
    require("onenord").setup {
      theme = "dark",
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
        -- Floating window borders
        FloatBorder = { fg = "#5E81AC", bg = "NONE" },
        --NormalFloat = { bg = "#2E3440" }, -- Darker background for floats

        -- LSP floating windows
        LspInfoBorder = { fg = "#5E81AC" },

        -- Diagnostic floating windows
        DiagnosticFloatingError = { fg = "#BF616A", bg = "#2E3440" },
        DiagnosticFloatingWarn = { fg = "#EBCB8B", bg = "#2E3440" },
        DiagnosticFloatingInfo = { fg = "#81A1C1", bg = "#2E3440" },
        DiagnosticFloatingHint = { fg = "#A3BE8C", bg = "#2E3440" },

        -- Telescope borders
        TelescopeBorder = { fg = "#5E81AC", bg = "NONE" },
        TelescopePromptBorder = { fg = "#5E81AC", bg = "NONE" },
        TelescopeResultsBorder = { fg = "#5E81AC", bg = "NONE" },
        TelescopePreviewBorder = { fg = "#5E81AC", bg = "NONE" },

        -- Which-key borders
        WhichKeyBorder = { fg = "#5E81AC", bg = "NONE" },

        -- Completion menu borders
        CmpBorder = { fg = "#5E81AC", bg = "NONE" },
        CmpDocBorder = { fg = "#5E81AC", bg = "NONE" },
        -- Variable field access (variable->field, variable.field)
        --["VariableField"] = { fg = "#2d49ff" },

        -- Boolean values (true, false)
        ["Boolean"] = { fg = "#4989ff" }, -- Base boolean group
        ["@boolean"] = { fg = "#4989ff" }, -- Tree-sitter booleans
        ["@constant.builtin.boolean"] = { fg = "#4989ff" }, -- Tree-sitter boolean constants
        ["cppBoolean"] = { fg = "#4989ff" }, -- C++ boolean values

        -- Boolean type (bool)
        ["Type"] = { fg = "#4989ff" }, -- Base type group
        ["@type"] = { fg = "#4989ff" }, -- Tree-sitter types
        ["StorageClass"] = { fg = "#4989ff" }, -- Storage class specifiers

        -- FIX: "if" should not be bold - need to specify color AND bold = false
        ["Conditional"] = { fg = "#df60ff", bold = false },
        ["@keyword.conditional"] = { fg = "#df60ff", bold = false },
        ["cConditional"] = { fg = "#df60ff", bold = false },

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

        ["@constructor"] = { fg = "#4989ff" },
        ["Number"] = { fg = "#4989ff" },
        ["@number"] = { fg = "#4989ff" },
        ["@type.builtin"] = { fg = "#4989ff" },
        ["@lsp.typemod.type.defaultLibrary.cpp"] = { fg = "#4989ff", bold = false },
        ["@lsp.mod.defaultLibrary.cpp"] = { fg = "#267F99", bold = false },
        --["@lsp.type.variable.cpp"] = { fg = "#2d49ff", bold = false },

        -- C++ property/field access highlighting
        --["@property"] = { fg = "#2d49ff", bold = false },

        --["@lsp.type.property.cpp"] = { fg = "#2d49ff", bold = false },
        --["@lsp.mod.classScope.cpp"] = { fg = "#2d49ff", bold = false },
        --["@lsp.typemod.property.classScope.cpp"] = { fg = "#2d49ff" },
        --["@lsp.typemod.property.defaultLibrary.cpp"] = { fg = "#2d49ff" },
        ["cppString"] = { fg = "#00FF00", bold = false },
        ["cType"] = { fg = "#4989ff", bold = false },

        -- CORRECT comment highlight groups
        ["Comment"] = { fg = "#009b00" }, -- Base comment group
        ["@comment"] = { fg = "#009b00" }, -- Tree-sitter comments
        ["cCommentL"] = { fg = "#009b00" }, -- C line comments
        ["cComment"] = { fg = "#009b00" }, -- C block comments
        ["@comment.line"] = { fg = "#009b00" }, -- Tree-sitter line comments
        ["@comment.block"] = { fg = "#009b00" }, -- Tree-sitter block comments

        -- Add these for #include preprocessing directives
        ["PreProc"] = { fg = "#df60ff" }, -- Base preprocessor group
        ["@preproc"] = { fg = "#df60ff" }, -- Tree-sitter preprocessor
        ["cInclude"] = { fg = "#df60ff" }, -- C #include specifically
        ["@keyword.directive"] = { fg = "#df60ff" }, -- Tree-sitter directive keywords
        ["@keyword.import"] = { fg = "#df60ff" }, -- Tree-sitter import keywords
        ["cPreCondit"] = { fg = "#df60ff" },

        -- "for" loop keyword - be specific
        ["@keyword.repeat"] = { fg = "#df60ff" }, -- Tree-sitter loop keywords (for, while, etc.)
        ["cRepeat"] = { fg = "#df60ff" }, -- C repeat statements
        ["IlluminateWord"] = { fg = "#60cdff" }, -- Vim's repeat keyword group
        ["IlluminatedWordText"] = { fg = "#60cdff", bold = false },
        -- angular
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
      vim.api.nvim_set_hl(0, "@keyword.conditional", { fg = "#df60ff", bold = false })
      vim.api.nvim_set_hl(0, "Conditional", { fg = "#df60ff", bold = false })
      vim.api.nvim_set_hl(0, "cConditional", { fg = "#df60ff", bold = false })

      -- Force LSP property highlights
      --vim.api.nvim_set_hl(0, "@property", { fg = "#2d49ff" })
      --vim.api.nvim_set_hl(0, "@lsp.type.property.cpp", { fg = "#2d49ff" })
      --vim.api.nvim_set_hl(0, "@lsp.mod.classScope.cpp", { fg = "#2d49ff" })
      --vim.api.nvim_set_hl(0, "@lsp.typemod.property.classScope.cpp", { fg = "#2d49ff" })
      --vim.api.nvim_set_hl(0, "@lsp.typemod.property.defaultLibrary.cpp", { fg = "#2d49ff" })
    end)
  end,
}
