return {
  {
    "nvim-lualine/lualine.nvim",
    config = true,
  },
  "nvim-tree/nvim-web-devicons",
  {
    "stevearc/dressing.nvim",
    opts = {
      input = { insert_only = false },
      select = { enabled = false },
    },
  },
  {
    "rcarriga/nvim-notify",
    cmd = { "Notifications", "NotificationsClear" },
    keys = {
      -- TODO: fzf notifications history
      {
        "<leader>n",
        "<Cmd>Notifications<CR>",
        desc = "Open notifications log",
      },
      {
        "<leader>N",
        "<Cmd>NotificationsClear<CR>",
        desc = "Clear notifications log",
      },
    },
    init = function()
      vim.notify = function(msg, level, opts)
        vim.notify = require "notify"
        vim.notify(msg, level, opts)
      end
    end,
    opts = {
      max_width = 42,
      minimum_width = 42,
      render = "wrapped-default",

      merge_duplicates = false,
      timeout = 3000,
    },
    config = function(_, opts)
      require("notify").setup(opts)

      local c_l_extented_rhs = vim.fn.maparg("<C-l>", "", false, false)
        .. "<Cmd>lua require('notify').dismiss()<CR>"
      vim.keymap.set("", "<C-l>", c_l_extented_rhs)
    end,
  },
}
