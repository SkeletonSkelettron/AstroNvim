-- File: ~/.config/nvim/lua/plugins/telescope.lua

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.x', -- Use the latest stable tag
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    -- This is where we set up Telescope
    local builtin = require('telescope.builtin')

    -- Set up some basic keymaps to start using Telescope
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep (Project Search)' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help Tags' })

    -- Telescope setup call with some custom options
    require('telescope').setup({
      defaults = {
        -- You can configure default behavior for all pickers here
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    })

    -- Load the fzf-native extension
    require('telescope').load_extension('fzf')
  end
}
