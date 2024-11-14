return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		config = function()
			require("catppuccin").setup({
				transparent_background = false,
				color_overrides = {
					mocha = {
						text = "#f2f4f8",
						subtext1 = "#dde1E6",
						subtext0 = "#c1c7cd",
						overlay2 = "#a2a9b0",
						overlay1 = "#878d96",
						overlay0 = "#697077",
						surface2 = "#4d5358",
						surface1 = "#697077",
						surface0 = "#21272a",
						base = "#121619",
						mantle = "#090b0c",
						crust = "#000000",
					},
				},
			})
		end,
		priority = 1000,
	},
	{
		'arzg/vim-colors-xcode',
		lazy = false,
	},
}
