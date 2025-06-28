-- ~/.config/nvim/lua/user/utils.lua

local M = {} -- M is a common convention for a module table

function M.inspect_word_and_highlight()
  local current_line = vim.fn.line "."
  local current_col = vim.fn.col "."

  local word_under_cursor = vim.fn.expand "<cword>"
  local display_message = {}

  if word_under_cursor and word_under_cursor ~= "" then
    table.insert(display_message, { "Word: ", "Normal" })
    table.insert(display_message, { word_under_cursor, "Statement" })
    table.insert(display_message, { " | ", "Normal" })
  end

  local ts_captures = vim.treesitter.get_captures_at_cursor()
  local ts_capture_info = {}

  if ts_captures and #ts_captures > 0 then
    table.insert(display_message, { "TS Captures (Color): ", "Normal" })
    for _, capture_id in ipairs(ts_captures) do
      local capture_name = vim.treesitter.get_capture_name_for_id(capture_id)
      -- Construct the highlight group name as nvim-treesitter maps it
      local hl_group_name = "TS" .. capture_name:gsub("^@", ""):gsub("%.", "_")

      -- === CORRECTED LINE: Using vim.api.nvim_get_hl() ===
      local hl_info = vim.api.nvim_get_hl(0, { name = hl_group_name, rgb = true }) -- `0` for current window, `rgb = true` for RGB values

      local fg_color = hl_info and hl_info.fg and string.format("#%06x", hl_info.fg) or "N/A"
      local bg_color = hl_info and hl_info.bg and string.format("#%06x", hl_info.bg) or "N/A"

      table.insert(ts_capture_info, string.format("%s (fg:%s, bg:%s)", capture_name, fg_color, bg_color))
    end
    table.insert(display_message, { table.concat(ts_capture_info, ", "), "Type" })
  else
    -- Fallback to Vim's traditional syntax ID if no Tree-sitter captures
    local syn_id = vim.fn.synIDtrans(vim.fn.synID(current_line, current_col, 1))
    local hl_name = vim.fn.synIDattr(syn_id, "name")

    if hl_name and hl_name ~= "" then
      -- === CORRECTED LINE: Using vim.api.nvim_get_hl() ===
      local hl_info = vim.api.nvim_get_hl(0, { name = hl_name, rgb = true })
      local fg_color = hl_info and hl_info.fg and string.format("#%06x", hl_info.fg) or "N/A"
      local bg_color = hl_info and hl_info.bg and string.format("#%06x", hl_info.bg) or "N/A"
      table.insert(display_message, { "Vim Group: ", "Normal" })
      table.insert(display_message, { string.format("%s (fg:%s, bg:%s)", hl_name, fg_color, bg_color), "Type" })
    else
      table.insert(display_message, { "No specific highlight found.", "Normal" })
    end
  end

  vim.api.nvim_echo(display_message, true, {})
end

return M
