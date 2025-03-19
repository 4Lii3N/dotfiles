-- Global options
local global_opts = {
  tabstop    = 2,
  shiftwidth = 2,
  scrolloff  = 7,
  textwidth  = 0,
  wrapmargin = 0,
  pumheight  = 15,
  guicursor  = "n-v-i-c:block-Cursor",
  splitright = true,
  undofile   = true,
  undolevels = 1000,
  expandtab  = true
}

for key, value in pairs(global_opts) do
  vim.opt[key] = value
end

-- Window-local options
local window_opts = {
  number         = true,
  relativenumber = true,
  cursorline     = true,
  wrap           = false,
}

for key, value in pairs(window_opts) do
  vim.wo[key] = value
end

-- Filetype associations
vim.filetype.add({
  extension = {
    mdx = "markdown",
  },
})

vim.diagnostic.config({
  virtual_text = true
})
