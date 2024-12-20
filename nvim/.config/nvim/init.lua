local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("keymaps")
require("vim-options")
require("lazy").setup("plugins")

-- Add highlights for Oil
vim.api.nvim_set_hl(0, 'OilDir', { link = 'Directory' })
vim.api.nvim_set_hl(0, 'OilDirIcon', { link = 'Special' })
vim.api.nvim_set_hl(0, 'OilFile', { link = 'None' })
vim.api.nvim_set_hl(0, 'OilFileIcon', { link = 'Special' })
