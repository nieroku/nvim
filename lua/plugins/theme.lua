return {
  {
    "raddari/last-color.nvim",
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
    config = function()
      vim.cmd.colorscheme(require("last-color").recall() or "gruvbox")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    event = "VeryLazy",
    opts = {
      italic = { strings = false },
      contrast = "hard",
    },
  },
  {
    "neanias/everforest-nvim",
    name = "everforest",
    version = "*",
    event = "VeryLazy",
    opts = { background = "medium" },
  },
  {
    "oneslash/helix-nvim",
    version = "*",
    event = "VeryLazy",
  },
}
