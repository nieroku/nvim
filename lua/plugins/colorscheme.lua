return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    keys = {
      {
        "<leader>tl",
        function()
          vim.o.background = ({
            ["light"] = "dark",
            ["dark"] = "light",
          })[vim.o.background]
        end,
        desc = "Toggle background (dark/light)",
      },
    },
    config = function(_, opts)
      local everforest = require "everforest"
      everforest.setup(opts)
      everforest.load()
    end,
  },
}
