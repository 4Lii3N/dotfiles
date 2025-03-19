return {
	{
		"tpope/vim-fugitive",
		lazy = false,
		keys = {
			{ "<leader>gs", function() vim.cmd.Git() end, desc = "Git status" },
		}
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				on_attach = function(bufnr)
					local gitsigns = require('gitsigns')

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map('n', '<leader>bi', gitsigns.toggle_current_line_blame)
				end
			})
		end,
	},
}
