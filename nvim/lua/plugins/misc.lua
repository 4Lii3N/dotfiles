return {
  {
    dir = "~/myGit/dev/template_literal.nvim",
    name = "template_literal_edit",
    lazy = false,
    config = function()
      require('template_literal_edit')
    end
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false
  },
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
  -- 	{
  --   "folke/snacks.nvim",
  --   ---@type snacks.Config
  --   opts = {
  --     indent = {
  --       -- your indent configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   }
  -- }
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
    "0xrusowsky/nvim-ctx-ingest",
    dependencies = {
      "nvim-web-devicons", -- required for file icons
    },
    config = function()
      require("nvim-ctx-ingest").setup()
    end,
    keys = {
      {
        "<leader>ci",
        "<cmd>CtxIngest<cr>",
        desc = "Contextual Ingest",
      },
    }
  }
}
