--if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    -- 'ensure_installed' is a key within the 'opts' table.
    ensure_installed = {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers.
      -- e.g., "c", "cpp", "javascript", "python", "typescript"
    },
    -- 'highlight' is also a key within the 'opts' table.
    highlight = {
      enable = false, -- Disable highlight globally if this is your intention
    },
    -- You can add other global Treesitter configurations here as direct keys in this 'opts' table.
    -- For example, to enable Treesitter-based indentation:
    -- indent = { enable = true },
  },
  config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
}
