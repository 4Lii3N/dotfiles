local colors = require('colors')

-- UFO folding
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

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
						text = colors.text,
						subtext1 = colors.subtext1,
						subtext0 = colors.subtext0,
						overlay2 = colors.overlay2,
						overlay1 = colors.overlay1,
						overlay0 = colors.overlay0,
						surface2 = colors.surface2,
						surface1 = colors.overlay0,
						surface0 = colors.surface0,
						base = colors.base,
						mantle = colors.mantle,
						crust = colors.crust,
					},
				},
			})

			vim.cmd.colorscheme "catppuccin"

			local highlights = {
				Normal         = { bg = "none" },
				NormalNC       = { bg = "none" },
				NonText        = { bg = "none" },
				LineNrAbove    = { fg = colors.line_nr },
				LineNr         = { fg = colors.line_nr },
				LineNrBelow    = { fg = colors.line_nr },
				StatusLine     = { bg = colors.bg_dark },
				StatusLineNC   = { bg = colors.bg_dark },
				ColorColumn    = { bg = colors.bg_dark },
				CursorLine     = { bg = colors.bg_dark },
				EndOfBuffer    = { bg = "none" },
				FloatBorder    = { bg = colors.bg_float, fg = colors.bg_float },
				NormalFloat    = { bg = colors.bg_float },
				NormalMarkdown = { bg = colors.bg_float },
			}

			for group, opts in pairs(highlights) do
				vim.api.nvim_set_hl(0, group, opts)
			end

			-- vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
			-- 	callback = function()
			-- 		local win = vim.api.nvim_get_current_win()
			-- 		local ft = vim.bo.filetype
			--
			-- 		if ft == "markdown" then -- Replace with your filetype
			-- 			vim.wo[win].winhighlight = "Normal:NormalMarkdown"
			-- 		else
			-- 			vim.wo[win].winhighlight = "Normal:Normal"
			-- 		end
			-- 	end
			-- })
		end,
		priority = 1000,
		opts = {
			integrations = { blink_cmp = true },
		}
	},
	{
		"nvim-lualine/lualine.nvim",
		enabled = true,
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- Eviline config for lualine
			-- Author: shadmansaleh
			-- Credit: glepnir
			local lualine = require('lualine')

			local conditions = {
				buffer_not_empty = function()
					return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
				end,
				hide_in_width = function()
					return vim.fn.winwidth(0) > 80
				end,
				check_git_workspace = function()
					local filepath = vim.fn.expand('%:p:h')
					local gitdir = vim.fn.finddir('.git', filepath .. ';')
					return gitdir and #gitdir > 0 and #gitdir < #filepath
				end,
			}

			-- Config
			local config = {
				options = {
					-- Disable sections and component separators
					component_separators = '',
					section_separators = '',
					theme = {
						-- We are going to use lualine_c an lualine_x as left and
						-- right section. Both are highlighted by c theme .  So we
						-- are just setting default looks o statusline
						normal = { c = { fg = colors.fg, bg = colors.bg } },
						inactive = { c = { fg = colors.fg, bg = colors.bg } },
					},
				},
				sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					-- These will be filled later
					lualine_c = {},
					lualine_x = {},
				},
				inactive_sections = {
					-- these are to remove the defaults
					lualine_a = {},
					lualine_b = {},
					lualine_y = {},
					lualine_z = {},
					lualine_c = {},
					lualine_x = {},
				},
			}

			-- Inserts a component in lualine_c at left section
			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end

			-- Inserts a component in lualine_x at right section
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			ins_left {
				function()
					return '>'
				end,
				color = { fg = colors.bg },    -- Sets highlighting of component
				padding = { left = 0, right = 1 }, -- We don't need space before this
			}

			ins_left {
				-- mode component
				function()
					-- return ''
					return ''
					-- return '颗摁岸'
					-- return 'ブラント'
				end,
				color = function()
					-- auto change color according to neovims mode
					local mode_color = {
						n = colors.red,
						i = colors.green,
						v = colors.blue,
						[''] = colors.blue,
						V = colors.blue,
						c = colors.magenta,
						no = colors.red,
						s = colors.orange,
						S = colors.orange,
						[''] = colors.orange,
						ic = colors.yellow,
						R = colors.violet,
						Rv = colors.violet,
						cv = colors.red,
						ce = colors.red,
						r = colors.cyan,
						rm = colors.cyan,
						['r?'] = colors.cyan,
						['!'] = colors.red,
						t = colors.red,
					}
					return { fg = mode_color[vim.fn.mode()] }
				end,
				padding = { right = 1 },
			}

			ins_left {
				-- filesize component
				'filesize',
				cond = conditions.buffer_not_empty,
			}

			ins_left {
				'filename',
				cond = conditions.buffer_not_empty,
				color = { fg = colors.violet },
			}

			ins_left { 'location' }

			ins_left { 'progress', color = { fg = colors.fg } }

			ins_left {
				'diagnostics',
				sources = { 'nvim_diagnostic' },
				symbols = { error = ' ', warn = ' ', info = ' ' },
				diagnostics_color = {
					color_error = { fg = colors.red },
					color_warn = { fg = colors.yellow },
					color_info = { fg = colors.cyan },
				},
			}

			-- Insert mid section. You can make any number of sections in neovim :)
			-- for lualine it's any number greater then 2
			ins_left {
				function()
					return '%='
				end,
			}

			ins_left {
				""
			}

			-- Add components to right sections
			ins_right {
				'o:encoding',   -- option component same as &encoding in viml
				fmt = string.upper, -- I'm not sure why it's upper case either ;)
				cond = conditions.hide_in_width,
				color = { fg = colors.fg },
			}

			ins_right {
				'fileformat',
				fmt = string.upper,
				icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
				color = { fg = colors.fg },
			}

			ins_right {
				'branch',
				icon = '',
				color = { fg = colors.violet },
			}

			ins_right {
				'diff',
				-- Is it me or the symbol for modified us really weird
				symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
				diff_color = {
					added = { fg = colors.green },
					modified = { fg = colors.orange },
					removed = { fg = colors.red },
				},
				cond = conditions.hide_in_width,
			}

			ins_right {
				function()
					return '<'
				end,
				color = { fg = colors.bg },
				padding = { left = 1 },
			}

			-- Now don't forget to initialize lualine
			lualine.setup(config)
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		lazy = false,
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { "%s" },                  click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
							{ text = { builtin.foldfunc },      click = "v:lua.ScFa" },
						},
					})
				end,
			},
		},
		event = "BufReadPost",
		opts = {
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
		},

		init = function()
			vim.keymap.set("n", "zR", function()
				require("ufo").openAllFolds()
			end)
			vim.keymap.set("n", "zM", function()
				require("ufo").closeAllFolds()
			end)
		end,
	},
	{
		"j-hui/fidget.nvim",
		lazy = false,
		config = function()
			require("fidget").setup({
				progress = {
					display = {
						progress_style = "TelescopeNormal",
					}
				}
			})
		end
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
					tailwind = true,                           -- Enable tailwind colors
					-- parsers can contain values used in |user_default_options|
					sass = { enable = true, parsers = { "css" }, }, -- Enable sass colors
					virtualtext = "■",
					-- update color values even if buffer is not focused
					-- example use: cmp_menu, cmp_docs
					always_update = true
				},
				-- all the sub-options of filetypes apply to buftypes
				buftypes = {},
			})
		end
	},
	{ "nvzone/volt", lazy = true },
	{ "nvzone/menu", lazy = true },
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		lazy = false,
		config = function()
			require('render-markdown').setup({
				file_types = { 'markdown', 'copilot-chat' },
				callout = {
					user = { raw = '[!USER]', rendered = ' User', highlight = 'RenderMarkdownWarn' },
					copilot = { raw = '[!COPILOT]', rendered = '  Copilot', highlight = 'RenderMarkdownInfo' },
				}
			})
		end,
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
}
