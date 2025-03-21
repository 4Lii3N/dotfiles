return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		lazy = false,
		build = ":TSUpdate",
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>",      desc = "Decrement selection", mode = "x" },
		},
		--@type TSConfig
		--@diagnostic disable-next-line: missing-fields
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = { "bash", "c", "diff", "html", "javascript", "jsdoc", "json", "jsonc", "lua", "luadoc", "luap", "markdown", "markdown_inline", "python", "query", "regex", "toml", "tsx", "typescript", "vim", "vimdoc", "yaml", },
		},
		--@param opts TSConfig
		config = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				--@type table<string, boolean>
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"davidmh/mdx.nvim",
		config = true,
		dependencies = { "nvim-treesitter/nvim-treesitter" }
	}
}
