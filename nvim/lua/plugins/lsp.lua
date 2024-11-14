-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client.server_capabilities.inlayHintProvider then
-- 			vim.lsp.inlay_hint.enable(true)
-- 		end
-- 	end
-- })

return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		enabled = true,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			local cmp = require("cmp")
			vim.opt.completeopt = { "menu", "menuone", "noselect" }

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp",                group_index = 2 },
					{ name = "nvim_lua",                group_index = 2 },
					{ name = "nvim_lsp_signature_help", group_index = 2 },
					{ name = "copilot",                 group_index = 2, priority = 100, },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				-- window = {
				-- 	completion = {
				-- 		winhighlight = "Normal:TelescopeNormal,FloatBorder:Pmenu,Search:None",
				-- 	}
				-- },
				formatting = {
					format = function(_, item)
						local icons = {
							Array         = " ",
							Boolean       = "󰨙 ",
							Class         = " ",
							Codeium       = "󰘦 ",
							Color         = " ",
							Control       = " ",
							Collapsed     = " ",
							Constant      = "󰏿 ",
							Constructor   = " ",
							Copilot       = " ",
							Enum          = " ",
							EnumMember    = " ",
							Event         = " ",
							Field         = " ",
							File          = " ",
							Folder        = " ",
							Function      = "󰊕 ",
							Interface     = " ",
							Key           = " ",
							Keyword       = " ",
							Method        = "󰊕 ",
							Module        = " ",
							Namespace     = "󰦮 ",
							Null          = " ",
							Number        = "󰎠 ",
							Object        = " ",
							Operator      = " ",
							Package       = " ",
							Property      = " ",
							Reference     = " ",
							Snippet       = " ",
							String        = " ",
							Struct        = "󰆼 ",
							TabNine       = "󰏚 ",
							Text          = " ",
							TypeParameter = " ",
							Unit          = " ",
							Value         = " ",
							Variable      = "󰀫 ",
						}
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end
						return item
					end,
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		enabled = true,
		lazy = false,
		config = function()
			require("copilot_cmp").setup()
		end
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local lspconfig = require('lspconfig')
			local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer", "tsserver", "cssls", "clangd", "tailwindcss" }
			})

			require("mason-lspconfig").setup_handlers {
				function(server_name)
					lspconfig[server_name].setup {
						capabilities = lsp_capabilities,
					}
				end,
				['tsserver'] = function()
					lspconfig.tsserver.setup({
						init_options = {
							preferences = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = true,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
								importModuleSpecifierPreference = 'non-relative'
							},
						},
						capabilities = lsp_capabilities,
						settings = {
							completions = {
								completeFunctionCalls = true
							}
						}
					})
				end,
				["tailwindcss"] = function()
					lspconfig.tailwindcss.setup {
						capabilities = lsp_capabilities,
					}
				end,
				["rust_analyzer"] = function()
					require("rust-tools").setup({
						root_dir = lspconfig.util.root_pattern('Cargo.toml'),
					})
					lspconfig.rust_analyzer.setup {
						capabilities = lsp_capabilities,
					}
				end,
				["cssls"] = function()
					lspconfig.cssls.setup {
						capabilities = lsp_capabilities,
					}
				end,
				["emmet_ls"] = function()
					lspconfig.emmet_ls.setup {
						capabilities = lsp_capabilities,
					}
				end,
				["emmet_language_server"] = function()
					lspconfig.emmet_language_server.setup {
						capabilities = lsp_capabilities,
					}
				end,
				["lua_ls"] = function()
					Lua = {
						diagnostics = { globals = { 'vim' } }
					}
					lspconfig.lua_ls.setup {
						capabilities = lsp_capabilities,
					}
				end,
				["clangd"] = function()
					lspconfig.clangd.setup {
						capabilities = lsp_capabilities,
					}
				end,
			}
		end
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<space>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<space>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end
	},
	{
		'simrat39/rust-tools.nvim',
		config = function()
			require('rust-tools').setup {
				server = {
					on_attach = function(_, bufnr)
						-- Hover actions
						vim.keymap.set("n", "<C-space>", require('rust-tools').hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<Leader>a", require('rust-tools').code_action_group.code_action_group,
							{ buffer = bufnr })
					end,
				},
			}
		end
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
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
		end,
	}
}
