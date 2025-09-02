-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.python")
require("gruvbox").setup({
  contrast = "hard",
})
vim.cmd("colorscheme gruvbox")
