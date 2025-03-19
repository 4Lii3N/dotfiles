return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "neovim/nvim-lspconfig" },
		opts = function()
			local lspconfig = require('lspconfig')
			local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

			---@type MasonLspconfigSettings

			return {
				ensure_installed = { "lua_ls", "rust_analyzer", "phpactor", "ts_ls", "cssls", "clangd", "tailwindcss" },
				automatic_installation = false,
				handlers = {
					function(server_name)
						lspconfig[server_name].setup({ capabilities = lsp_capabilities })
					end,
				},
				['biome'] = function()
					lspconfig.biome.setup({
						capabilities = lsp_capabilities,
						cmd = { 'biome', 'lsp-proxy' },
						filetypes = {
							'astro',
							'css',
							'graphql',
							'javascript',
							'javascriptreact',
							'json',
							'jsonc',
							'svelte',
							'typescript',
							'typescript.tsx',
							'typescriptreact',
							'vue',
						},
						root_dir = util.root_pattern('biome.json', 'biome.jsonc'),
						single_file_support = false,
					})
				end,
				['ts_ls'] = function()
					lspconfig.ts_ls.setup({
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
						on_attach = function(client)
							client.server_capabilities.documentFormattingProvider = false
						end,
						capabilities = lsp_capabilities,
						settings = {
							completions = {
								completeFunctionCalls = true
							}
						}
					})
				end,
				["rust_analyzer"] = function()
					require("rust-tools").setup({
						root_dir = lspconfig.util.root_pattern('Cargo.toml'),
					})
					lspconfig.rust_analyzer.setup {
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
			}
		end,
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
			local signs = { Error = "", Warn = "", Hint = "", Info = "" }
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
		"folke/lazydev.nvim",
		lazy = false,
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		'saghen/blink.compat',
		version = '*',
		lazy = true,
		opts = {},
	},
	{
		'saghen/blink.cmp',
		dependencies = { 'rafamadriz/friendly-snippets', "zbirenbaum/copilot-cmp" },
		version = '*',
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = 'enter',
				['<C-k>'] = { 'select_prev', 'fallback' },
				['<C-j>'] = { 'select_next', 'fallback' },
				['<C-y>'] = { 'select_and_accept', 'fallback' },
			},
			signature = { enabled = true },
			completion = {
				-- ghost_text = { enabled = true },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 20,
				},
				menu = {
					draw = {
						columns = {
							{ "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" }
						}
					}
				},
				list = {
					selection = { preselect = false, auto_insert = false },
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono',
				kind_icons = {
					Copilot = "",
					Text = '󰉿',
					Method = '󰊕',
					Function = '󰊕',
					Constructor = '󰒓',

					Field = '󰜢',
					Variable = '󰆦',
					Property = '󰖷',

					Class = '󱡠',
					Interface = '󱡠',
					Struct = '󱡠',
					Module = '󰅩',

					Unit = '󰪚',
					Value = '󰦨',
					Enum = '󰦨',
					EnumMember = '󰦨',

					Keyword = '󰻾',
					Constant = '󰏿',

					Snippet = '󱄽',
					Color = '󰏘',
					File = '󰈔',
					Reference = '󰬲',
					Folder = '󰉋',
					Event = '󱐋',
					Operator = '󰪚',
					TypeParameter = '󰬛',
				},
			},
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot', 'lazydev' },
				providers = {
					copilot = {
						name = 'copilot',
						module = 'blink.compat.source',
						transform_items = function(_, items)
							local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
							local kind_idx = #CompletionItemKind + 1
							CompletionItemKind[kind_idx] = "Copilot"
							for _, item in ipairs(items) do
								item.kind = kind_idx
							end
							return items
						end,
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				}
			},
		},
		opts_extend = { "sources.default" }
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
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },                -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken",                       -- Only on MacOS or Linux
		lazy = false,
		config = function(_)
			local chat = require("CopilotChat")
			chat.setup({
				highlight_headers = false,
				-- separator = '---',
				error_header = '> [!ERROR] Error ',
				question_header = '> [!USER] User ',
				answer_header = '> [!COPILOT] Copilot ',
				prompts = {
					WCAG = {
						prompt =
						'> /COPILOT_REVIEW\n\nIf there is any HTML or JSX/TSX present in this code please check that all aria labels etc. have been set correctly and that it otherwise complies with WCAG'
					},
					Types = {
						prompt =
						'> /COPILOT_GENERATE\n\nIf this code is part of a typed language like Typescript, Rust, etc. check if all types are correctly set and precise enough, generate any missing ones and specify the ones that arent very precise, if its a language that usually doesnt have static types check if something like JSDoc could be used instead and create the appropriate type annotations'
					},
					RefactorStories = {
						prompt = [[
						> /COPILOT_GENERATE\n\n
						you will be given a .mdx storybook story file of a component that will roughly look like this:
						import { Meta, Story, Canvas, Source } from '@storybook/blocks';
						import { withKnobs, boolean } from '@storybook/addon-knobs';
						import data from './a-anchorlink.data';
						import template from './a-anchorlink.template.twig';
						import { gridWrapper } from '../../global/js/lib/utils/gridWrapper';

						const templateCode = encodeURI(require('!!raw-loader!./a-anchorlink.template.twig').default);

						<Meta name="Pattern Library/Atoms" decorators={[withKnobs]} />

						# Anchorlink

						Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ea voluptatum beatae adipisci tenetur consequuntur libero culpa autem veniam aliquam error.

						<Canvas mdxSource={templateCode}>
							<Story name="Anchorlink">
								{() => {
									return gridWrapper(template(data), boolean('Show grid?', false));
								}}
							</Story>
						</Canvas>

						you then need to refactor this into a storybook 8.5.2 compliant stories.js file and a .docs.js file which should follow this basic schema:
						<component>.docs.js:
						import React from 'react';
						import PropTypes from 'prop-types';
						import template from 'atoms/a-button/a-button.template.twig';
						import templateSource from '!!raw-loader!atoms/a-button/a-button.template.twig';

						export const Button = (props) => {
							const templateProps = {
								...props,
								button: {
									...props.button,
								},
							};

							return <div dangerouslySetInnerHTML={{ __html: template(templateProps) }} />;
						};

						console.log(Button);

						Button.sourceCode = templateSource;

						Button.propTypes = {
							button: PropTypes.shape({
								text: PropTypes.string.isRequired,
								href: PropTypes.string.isRequired,
								type: PropTypes.oneOf(['primary', 'secondary']).isRequired,
								target: PropTypes.oneOf(['_self', '_blank', '_parent', '_top']),
								title: PropTypes.string,
								icon: PropTypes.shape({
									name: PropTypes.string,
									position: PropTypes.oneOf(['left', 'right']),
								}),
							}),
							uiVariant: PropTypes.oneOf(['syzygy']),
							showGrid: PropTypes.bool,
						};

						Button.defaultProps = {
							button: {
								text: 'Click me', // Default from your data
								href: '#',
								type: 'primary',
								target: '_self',
								title: '',
								icon: {
									name: '', // Default no icon
									position: 'left',
								},
							},
							uiVariant: 'syzygy',
							showGrid: false,
						};

						<component>.stories.js:
						import React from 'react';
						import { Button } from 'atoms/a-button/a-button.docs';

						export default {
							title: 'Pattern Library/Atoms/Button',
							component: Button,
							parameters: {
								layout: 'centered',
								docs: {
									source: {
										code: Button.sourceCode,
									},
								},
							},
						};

						const Template = (args) => (
							<>
								<div style={{ padding: '50px' }}>
									<Button {...args} />
								</div>
							</>
						);

						export const Primary = Template.bind({});
						Primary.args = {
							button: {
								text: 'Click me',
								href: '#',
								type: 'primary',
								target: '_self',
								title: '',
								icon: {
									name: '',
									position: 'left',
								},
							},
							uiVariant: 'syzygy',
							showGrid: false,
						};

						export const Secondary = Template.bind({});
						Secondary.args = {
							button: {
								text: 'Click me',
								href: '#',
								type: 'secondary',
								target: '_self',
								title: '',
								icon: {
									name: '',
									position: 'left',
								},
							},
							uiVariant: 'syzygy',
							showGrid: false,
						};


						]]
					},
					AddData = {
						prompt =
						[[> /COPILOT_GENERATE\n\nadd the import for data from the <component>.data.js and add it as the default data, heres an example:

example for a .docs.js file:
					import React from 'react';
import PropTypes from 'prop-types';
import template from './a-link.template.twig';
import templateSource from '!!raw-loader!atoms/a-link/a-link.template.twig';
import data from './a-link.data.js'

export const Link = (props) => {
	const templateProps = {
		...props,
		link: {
			...props.link,
		},
	};

	return <div dangerouslySetInnerHTML={{ __html: template(templateProps) }} />;
};

Link.sourceCode = templateSource;

Link.propTypes = {
	link: PropTypes.shape({
		text: PropTypes.string.isRequired,
		type: PropTypes.oneOf(['default', 'external']).isRequired,
		position: PropTypes.oneOf(['left', 'right']),
		customIcon: PropTypes.string,
		iconColor: PropTypes.string,
	}),
	showGrid: PropTypes.bool,
};

Link.defaultProps = {
	...data,
	showGrid: false,
};

example for a .stories.js file:
import React from 'react';
import { Link } from './a-link.docs';
import data from './a-link.data.js'

export default {
	title: 'Pattern Library/Atoms/Link',
	component: Link,
	parameters: {
		layout: 'centered',
		docs: {
			source: {
				code: Link.sourceCode,
			},
		},
	},
};

const Template = (args) => (
	<>
		<div style={{ padding: '50px' }}>
			<Link {...args} />
		</div>
	</>
);

export const Default = Template.bind({});
Default.args = {
	...data,
	showGrid: false,
};

export const External = Template.bind({});
External.args = {
	link: {
		text: 'External Link',
		type: 'external',
		position: 'left',
		customIcon: '',
		iconColor: '',
	},
	showGrid: false,
};


					]]
					}
				},
			})

			local select = require("CopilotChat.select")
			vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
				chat.ask(args.args, { selection = select.visual })
			end, { nargs = "*", range = true })

			-- Inline chat with Copilot
			vim.api.nvim_create_user_command("CopilotChatInline", function(args)
				chat.ask(args.args, {
					selection = select.visual,
					window = {
						layout = "float",
						relative = "cursor",
						width = 1,
						height = 0.4,
						row = 1,
					},
				})
			end, { nargs = "*", range = true })

			-- Restore CopilotChatBuffer
			vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
				chat.ask(args.args, { selection = select.buffer })
			end, { nargs = "*", range = true })

			-- Custom buffer for CopilotChat
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-*",
				callback = function()
					vim.opt_local.relativenumber = true
					vim.opt_local.number = true

					-- Get current filetype and set it to markdown if the current filetype is copilot-chat
					local ft = vim.bo.filetype
					if ft == "copilot-chat" then
						vim.bo.filetype = "markdown"
					end
				end,
			})
		end,
		event = "VeryLazy",
		keys = {
			{
				"<leader>at",
				function()
					local actions = require("CopilotChat.actions")
					require("plugins.custom.copilot_menu").pick(actions.prompt_actions())
				end,
				mode = "x",
				desc = "CopilotChat - Prompt actions (menu)",
			},
			{
				"<leader>av",
				":CopilotChatVisual",
				mode = "x",
				desc = "CopilotChat - Open in vertical split",
			},
			{
				"<leader>ax",
				":CopilotChatInline<cr>",
				mode = "x",
				desc = "CopilotChat - Inline chat",
			},
			{
				"<leader>af",
				":CopilotChatBuffer<cr>",
				mode = "n",
				desc = "CopilotChat - Toggle chat",
			},
		},
	},
}
