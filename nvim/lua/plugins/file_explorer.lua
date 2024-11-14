return {
	{
		'stevearc/oil.nvim',
		opts = {},
		lazy = false,
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		config = function()
			require("oil").setup({
				columns = {
					"icon",
					-- "permissions",
					-- "size",
					-- "mtime",
				},
				view_options = {
					show_hidden = true,
				}
			})
		end
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle current<cr>", desc = "NeoTree" },
		},
		cmd = 'Neotree',
		init = function()
			vim.api.nvim_create_autocmd('BufEnter', {
				-- make a group to be able to delete it later
				group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
				callback = function()
					local f = vim.fn.expand('%:p')
					if vim.fn.isdirectory(f) ~= 0 then
						vim.cmd('Neotree current dir=' .. f)
						-- neo-tree is loaded now, delete the init autocmd
						vim.api.nvim_clear_autocmds { group = 'NeoTreeInit' }
					end
				end
			})
			-- keymaps
		end,
		opts = {
			filesystem = {
				hijack_netrw_behavior = 'open_current'
			}
		}
	},
}
