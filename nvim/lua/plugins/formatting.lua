return {
  {
    "nvimtools/none-ls.nvim",
    lazy = false,
    config = function()
      local null_ls = require 'null-ls'
      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua.with {
            extra_args = { '--config-path', vim.fn.expand '~/.stylua.toml' },
          },
          null_ls.builtins.formatting.shfmt.with {
            extra_args = { '-i', '4' },
          },
          null_ls.builtins.diagnostics.gitlint.with {
            extra_args = { '--contrib=contrib-title-conventional-commits', '--ignore=body-is-missing' },
          },
        },
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      }
    end
  },
  require('lazy').setup({
    {
      'laytan/tailwind-sorter.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
      build = 'cd formatter && npm ci && npm run build',
      lazy = false,
      config = function()
        require('tailwind-sorter').setup({
          on_save_enabled = true,                                                                                    -- If `true`, automatically enables on save sorting.
          on_save_pattern = { '*.html', '*.js', '*.jsx', '*.tsx', '*.twig', '*.hbs', '*.php', '*.heex', '*.astro' }, -- The file patterns to watch and sort.
          node_path = 'node',
          trim_spaces = false,                                                                                       -- If `true`, trim any extra spaces after sorting.
        })
      end,
    },
  })
  -- {
  -- 	'stevearc/conform.nvim',
  -- 	opts = {},
  -- 	lazy = false,
  -- 	config = function()
  -- 		require("conform").setup({
  -- 			format_on_save = {
  -- 				-- These options will be passed to conform.format()
  -- 				timeout_ms = 500,
  -- 				lsp_fallback = true,
  -- 			},
  -- 		})
  -- 	end
  -- },
  -- {
  -- 	"MunifTanjim/prettier.nvim",
  -- 	lazy = false,
  -- 	config = function()
  -- 		local prettier = require("prettier")
  -- 		prettier.setup({
  -- 			bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
  -- 			filetypes = {
  -- 				"css",
  -- 				"graphql",
  -- 				"html",
  -- 				"javascript",
  -- 				"javascriptreact",
  -- 				"json",
  -- 				"less",
  -- 				"markdown",
  -- 				"scss",
  -- 				"typescript",
  -- 				"typescriptreact",
  -- 				"yaml",
  -- 			},
  -- 		})
  -- 	end
  -- },
  -- {
  -- 	"mfussenegger/nvim-lint",
  -- 	config = function()
  -- 		require("lint").linters_by_ft = {
  -- 			typescript = { "eslint" },
  -- 		}
  -- 	end
  -- }
}
