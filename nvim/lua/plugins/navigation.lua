local theme = require('colors')

return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- Set the required highlight groups for fzf-lua using the native API
			vim.api.nvim_set_hl(0, "FzfLuaNormal", { bg = theme.bg_dark })
			vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = theme.bg_highlight, bg = theme.bgAlt })
			vim.api.nvim_set_hl(0, "FzfLuaPreviewNormal", { bg = theme.bg_lighter })
			vim.api.nvim_set_hl(0, "FzfLuaPreviewBorder", { fg = theme.bg_dark, bg = theme.bg_dark })

			local fzf_lua = require('fzf-lua')
			fzf_lua.setup({
				"hide",
				winopts = {
					border = "none",
				},
				hls = {
					normal = 'FzfLuaNormal',
					border = 'FzfLuaBorder',
					preview_normal = 'FzfLuaPreviewNormal',
					preview_border = 'FzfLuaPreviewBorder',
				}
			})
		end,
		opts = {},
		keys = {
			{ "<leader><leader>", function() require("fzf-lua").files() end,                      desc = "FzfLua: Files" },
			{ "<leader>fg",       function() require("fzf-lua").live_grep({ resume = true }) end, desc = "FzfLua: Live Grep (Resume)" },
			{ "<leader>fb",       function() require("fzf-lua").buffers() end,                    desc = "FzfLua: Buffers" },
			{ "<leader>fh",       function() require("fzf-lua").help_tags() end,                  desc = "FzfLua: Help Tags" },
			{ "<leader>fo",       function() require("fzf-lua").oldfiles() end,                   desc = "FzfLua: Old Files" },
			{ "<leader>fr",       function() require("fzf-lua").lsp_references() end,             desc = "FzfLua: LSP References" },
			{ "<leader>fl",       function() require("fzf-lua").lsp_implementations() end,        desc = "FzfLua: LSP Implementations" },
		}
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set("n", "<leader>zm", function() harpoon:list():add() end)
			vim.keymap.set("n", "<leader>zr", function() harpoon:list():remove() end)
			vim.keymap.set("n", "<Leader>zz", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

			vim.keymap.set("n", "<Leader>z1", function() harpoon:list():select(1) end)
			vim.keymap.set("n", "<Leader>z2", function() harpoon:list():select(2) end)
			vim.keymap.set("n", "<Leader>z3", function() harpoon:list():select(3) end)
			vim.keymap.set("n", "<Leader>z4", function() harpoon:list():select(4) end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<Leader>zu", function() harpoon:list():prev() end)
			vim.keymap.set("n", "<Leader>zi", function() harpoon:list():next() end)

			vim.keymap.set("n", "<Leader>tt",
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list("term"))
				end)

			vim.keymap.set("n", "<Leader>ta",
				function()
					vim.cmd("term")
					harpoon:list("term"):append()
				end)

			vim.keymap.set("n", "<Leader>t1",
				function() harpoon:list("term"):select(1) end)

			vim.keymap.set("n", "<Leader>t2",
				function() harpoon:list("term"):select(2) end)
		end
	},
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
		end,
		keys = {
			{ "<leader>e", vim.cmd.Oil, desc = "Toggle Oil" },
		}
	},
	{
		'mbbill/undotree',
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
		}
	},
}
