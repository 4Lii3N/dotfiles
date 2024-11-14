vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true })

vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = "Toggle Oil" })

vim.keymap.set('n', '<leader><Leader>', "<cmd>lua require('telescope.builtin').find_files()<CR>", {})
vim.keymap.set('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<CR>", {})
vim.keymap.set('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<CR>", {})
vim.keymap.set('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<CR>", {})
vim.keymap.set("n", "<Leader>fo", "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
	{ noremap = true, silent = true })
vim.keymap.set("n", "<Leader>fr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", {})


-- vim.keymap.set('n', '<leader>zz', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', {})
-- vim.keymap.set('n', '<leader>zm', '<cmd>lua require("harpoon.mark").add_file()<CR>', {})
-- vim.keymap.set('n', '<leader>zi', '<cmd>lua require("harpoon.ui").nav_next()<CR>', {})
-- vim.keymap.set('n', '<leader>zu', '<cmd>lua require("harpoon.ui").nav_prev()<CR>', {})
-- vim.keymap.set('n', '<leader>zt', '<cmd>lua require("harpoon.term").gotoTerminal(1)<CR>', {})

vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

vim.keymap.set('n', '<leader>q', '<cmd>q<CR>', { desc = "Quit" })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = "Save" })
vim.keymap.set('n', '<leader>W', '<cmd>wq<CR>', { desc = "Save and Quit" })

vim.keymap.set('n', '<leader>v', '<cmd>vsplit<cr>', { desc = "Vertical Split" })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Move to the left window" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Move to the bottom window" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Move to the top window" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Move to the right window" })

vim.keymap.set('n', '<Leader>cs', '<cmd>nohlsearch<CR>', { desc = "Clear search" })

vim.keymap.set('n', '<Leader>gs', '<cmd>Git<CR>', { desc = "fugitive" })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Undo Tree" })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.keymap.set('v', '<leader>y', '"*y', { desc = "Copy to clipboard" })

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader>i", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)


-- EXPERIMENTAL

vim.keymap.set('n', '<Leader>te', "<cmd>TLE<CR>")
