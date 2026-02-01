-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end
-- if vim.g.neovide then
--   -- This might work, but can be inconsistent depending on the font and OS.
--   -- Ensure the font name is the exact name as registered on your system.
--   vim.o.guifont = "JetBrainsMono Nerd Font Light:h10"
-- end

vim.opt.rtp:prepend(lazypath)
vim.opt.guicursor = "n-v-c:block"
vim.opt.guicursor = "i:ver25"
vim.opt.clipboard = "unnamedplus"
-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.cpp", "*.h", "*.hpp", "*.c" },
  callback = function() vim.lsp.buf.format() end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "copilot-*",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false

    -- This is the key setting
    if vim.fn.exists "+winfixbuf" == 1 then vim.opt_local.winfixbuf = true end
  end,
})
require "lazy_setup"
require "polish"
require "CopilotChat"
