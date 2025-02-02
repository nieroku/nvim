return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  keys = {
    {
      "<F12>l",
      function()
        local next = { light = "dark", dark = "light" }
        vim.o.background = next[vim.o.background]
      end,
    },
  },
  opts = {
    italic = { strings = false },
    contrast = "hard",
  },
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.o.background = "dark"
    vim.cmd "colorscheme gruvbox"
  end,
}
