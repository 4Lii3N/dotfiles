local colors = {
	-- bg       = nil,
	bg       = '#121212',
	fg       = '#bbc2cf',
	yellow   = '#ECBE7B',
	cyan     = '#008080',
	darkblue = '#081633',
	green    = '#98be65',
	orange   = '#FF8800',
	violet   = '#a9a1e1',
	magenta  = '#c678dd',
	blue     = '#51afef',
	red      = '#ec5f67',
}

return {
	{
		'stevearc/conform.nvim',
		opts = {},
		lazy = false,
		config = function()
			require("conform").setup({
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		}
	},
	{
		'mbbill/undotree'
	},
	{
		'NvChad/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup({
				filetypes = { "*" },
				user_default_options = {
					RGB = true,      -- #RGB hex codes
					RRGGBB = true,   -- #RRGGBB hex codes
					names = true,    -- "Name" codes like Blue or blue
					RRGGBBAA = false, -- #RRGGBBAA hex codes
					AARRGGBB = false, -- 0xAARRGGBB hex codes
					rgb_fn = true,   -- CSS rgb() and rgba() functions
					hsl_fn = true,   -- CSS hsl() and hsla() functions
					css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available modes for `mode`: foreground, background,  virtualtext
					mode = "virtualtext", -- Set the display mode.
					-- Available methods are false / true / "normal" / "lsp" / "both"
					-- True is same as normal
					tailwind = false,                          -- Enable tailwind colors
					-- parsers can contain values used in |user_default_options|
					sass = { enable = true, parsers = { "css" }, }, -- Enable sass colors
					virtualtext = "■",
					-- update color values even if buffer is not focused
					-- example use: cmp_menu, cmp_docs
					always_update = false
				},
				-- all the sub-options of filetypes apply to buftypes
				buftypes = {},
			})
		end
	},
	{ "MunifTanjim/prettier.nvim" },
	{
		"ThePrimeagen/vim-apm",
		config = function()
			local apm = require("vim-apm")

			apm:setup({})
			vim.keymap.set("n", "<leader>apm", function() apm:toggle_monitor() end)
		end
	},
	{
		"dstein64/vim-startuptime",
		lazy = false
	},
	{
		"NStefan002/screenkey.nvim",
		lazy = false,
		version = "*", -- or branch = "dev", to use the latest commit
	}
}
