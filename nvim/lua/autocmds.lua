vim.cmd([[
  autocmd InsertEnter * setlocal norelativenumber
]])
vim.cmd([[
  autocmd InsertLeave * setlocal relativenumber
]])

vim.cmd([[
autocmd BufWinEnter,WinEnter term://* startinsert
]])
vim.cmd([[
	autocmd BufLeave term://* stopinsert
]])

-- Highlight text on yank remains unchanged
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if (vim.bo.filetype == "markdown") then
			vim.opt_local.wrap = false
		end
	end,
})
