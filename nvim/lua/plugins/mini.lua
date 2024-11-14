return {
	{
		'echasnovski/mini.nvim',
		lazy = false,
		version = '*',
		config = function()
			require('mini.indentscope').setup({
				symbol = '│',
				options = { try_as_border = true },
			})
			require('mini.comment').setup()
			-- require('mini.starter').setup({})
		end
	},
	-- {
	-- 	"echasnovski/mini.pairs",
	-- 	lazy = false,
	-- 	enabled = false,
	-- 	config = function()
	-- 		require('mini.pairs').setup()
	-- 	end
	-- },
	-- {
	-- 	"echasnovski/mini.comment",
	-- 	opts = {},
	-- 	config = function()
	-- 		require('mini.comment').setup()
	-- 	end
	-- },
	-- {
	-- 	'echasnovski/mini.starter',
	-- 	lazy = false,
	-- 	config = function()
	-- 		require('mini.starter').setup({})
	-- 	end
	-- },
}
