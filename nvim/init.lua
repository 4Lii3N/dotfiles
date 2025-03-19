vim.deprecate = function() end

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
vim.g.mapleader = " "

require("autocmds")
require("keymaps")
require("config")
require("lazy").setup("plugins", {
	defaults = { lazy = true },
	change_detection = {
		enabled = true,
		notify = false, -- get a notification when changes are found
	},
})
