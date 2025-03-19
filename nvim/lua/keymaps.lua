local mappings = {
  t = { -- Terminal mode mappings
    ["<Esc><Esc>"] = { "<C-\\><C-n>", { noremap = true } },
  },

  n = { -- Normal mode mappings
    ["<leader>bb"] = { "<cmd>e #<cr>", { desc = "Switch to Other Buffer" } },
    ["<leader>q"]  = { "<cmd>q<CR>", { desc = "Quit" } },
    ["<leader>w"]  = { "<cmd>w<CR>", { desc = "Save" } },
    ["<leader>W"]  = { "<cmd>wq<CR>", { desc = "Save and Quit" } },
    ["<leader>v"]  = { "<cmd>vsplit<cr>", { desc = "Vertical Split" } },
    ["<C-h>"]      = { "<C-w>h", { desc = "Move to the left window" } },
    ["<C-j>"]      = { "<C-w>j", { desc = "Move to the bottom window" } },
    ["<C-k>"]      = { "<C-w>k", { desc = "Move to the top window" } },
    ["<C-l>"]      = { "<C-w>l", { desc = "Move to the right window" } },
    ["<Leader>cs"] = { "<cmd>nohlsearch<CR>", { desc = "Clear search" } },
  },

  v = {                                                    -- Visual mode mappings
    ["H"]         = { "<gv", { desc = "Decrease indent" } }, -- Shift left
    ["J"]         = { ":m '>+1<CR>gv=gv", { desc = "Move line down" } },
    ["K"]         = { ":m '<-2<CR>gv=gv", { desc = "Move line up" } },
    ["L"]         = { ">gv", { desc = "Increase indent" } }, -- Shift right
    ["<leader>y"] = { '"*y', { desc = "Copy to clipboard" } },
    ["<leader>p"] = { '"*p', { desc = "Paste from clipboard" } },
  },
}

for mode, maps in pairs(mappings) do
  for lhs, mapping in pairs(maps) do
    local rhs, opts = mapping[1], mapping[2]
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
