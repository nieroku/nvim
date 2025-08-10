return {
  {
    "neanias/everforest-nvim",
    version = false,
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
      local everforest = require "everforest"
      everforest.setup()
      everforest.load()
    end,
  },
}
