-- Set number to relativenumber in normal mode
vim.cmd([[
  autocmd InsertEnter * setlocal norelativenumber
]])

-- Set number to number in insert mode
vim.cmd([[
  autocmd InsertLeave * setlocal relativenumber
]])

vim.cmd([[
autocmd BufWinEnter,WinEnter term://* startinsert
]])

vim.cmd([[
	autocmd BufLeave term://* stopinsert
]])

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local colors = {
	bg = "#111111",
	bgAlt = "#111111",
	bgHighlight = "#3c4048",
	fg = "#ffffff",
	grey = "#53606e",
	blue = "#4484d1",
	green = "#acf2e4",
	cyan = "#6bdfff",
	red = "#ff7ab2",
	yellow = "#fef937",
	magenta = "#ff7ab2",
	pink = "#ff7ab2",
	orange = "#ffa14f",
	purple = "#ff7ab2",
}

local t = colors
local theme = {}

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd("colorscheme catppuccin-mocha")

		vim.cmd('highlight TelescopeBorder guifg=' .. t.bgAlt .. ' guibg=' .. t.bgAlt)
		vim.cmd('highlight TelescopeNormal guibg=' .. t.bgAlt)
		vim.cmd('highlight TelescopePreviewBorder guifg=' .. t.bgAlt .. ' guibg=' .. t.bgAlt)
		vim.cmd('highlight TelescopePreviewNormal guibg=' .. t.bgAlt)
		vim.cmd('highlight TelescopePreviewTitle guifg=' .. t.bgAlt .. ' guibg=' .. t.bgHighlight)
		vim.cmd('highlight TelescopePromptBorder guifg=' .. t.bgAlt .. ' guibg=' .. t.bgAlt)
		vim.cmd('highlight TelescopePromptNormal guifg=' .. t.fg .. ' guibg=' .. t.bgAlt)
		vim.cmd('highlight TelescopePromptPrefix guifg=' .. t.fg .. ' guibg=' .. t.bgAlt)
		vim.cmd('highlight TelescopePromptTitle guifg=' .. t.bgAlt .. ' guibg=' .. t.bgHighlight)
		vim.cmd('highlight TelescopeResultsBorder guifg=' .. t.bgAlt .. ' guibg=' .. t.bgAlt)
		vim.cmd('highlight TelescopeResultsNormal guibg=' .. t.bgAlt)
		vim.cmd('highlight TelescopeResultsTitle guifg=' .. t.bgAlt .. ' guibg=' .. t.bgAlt)

		-- Additional highlight groups
		vim.cmd('highlight TelescopeBorder guifg=' .. t.bgHighlight)
		vim.cmd('highlight TelescopePromptTitle guifg=' .. t.fg)
		vim.cmd('highlight TelescopeResultsTitle guifg=' .. t.fg)
		vim.cmd('highlight TelescopePromptPrefix guifg=' .. t.fg)
		vim.cmd('highlight TelescopePreviewTitle guifg=' .. t.fg)
		vim.cmd('highlight TelescopeSelection guibg=' .. t.bgHighlight)
		vim.cmd('highlight TelescopePromptCounter guifg=' .. t.fg)

		--bg
		vim.cmd('highlight Normal guibg=none')
		vim.cmd('highlight NormalNC guibg=none')
		vim.cmd('highlight NonText guibg=none')
		vim.cmd('highlight Normal ctermbg=none')
		vim.cmd('highlight NormalNC ctermbg=none')
		vim.cmd('highlight NonText ctermbg=none')

		vim.cmd('highlight LineNrAbove guifg=#636363')
		vim.cmd('highlight LineNr guifg=#636363')
		vim.cmd('highlight LineNrBelow guifg=#636363')

		-- vim.cmd('highlight StatusLine guibg=#2F3037')
		-- vim.cmd('highlight StatusLineNC guibg=#2F3037')
		-- vim.cmd('highlight ColorColumn guibg=#2F3037')
		-- vim.cmd('highlight CursorLine guibg=#2F3037')
		vim.cmd('highlight StatusLine guibg=#111111')
		vim.cmd('highlight StatusLineNC guibg=#111111')
		vim.cmd('highlight ColorColumn guibg=#111111')
		vim.cmd('highlight CursorLine guibg=#111111')

		vim.cmd('highlight EndOfBuffer guibg=none')

		vim.cmd('highlight NeoTreeNormal ctermbg=none')
		vim.cmd('highlight NeoTreeNormal guibg=none')
	end
})


-- vim.cmd([[
--   autocmd BufEnter * lua require('gitsigns').toggle_current_line_blame()
-- ]])
