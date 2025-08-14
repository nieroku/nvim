return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "AndreM222/copilot-lualine",
      "arkav/lualine-lsp-progress",
    },
    opts = function()
      local copilot_section = {
        "copilot",
        cond = function()
          return vim.g.copilot_loaded
        end,
        show_colors = true,
      }
      return {
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename", "lsp_progress" },
          lualine_x = { copilot_section, "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = { "quickfix", "oil" },
      }
    end,
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
    "rachartier/tiny-inline-diagnostic.nvim",
    opts = {
      preset = "powerline",
      options = {
        multilines = { enabled = true },
      },
    },
    config = function(_, opts)
      require("tiny-inline-diagnostic").setup(opts)
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    cmd = "WhichKey",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show()
        end,
        mode = "",
        desc = "Show keymaps",
      },
      {
        "<C-\\>?",
        function()
          require("which-key").show()
        end,
        mode = { "i", "c", "t" },
        desc = "Show keymaps",
      },
    },
    opts = {
      delay = 1000,
      preset = "helix",
      win = { row = 1 },
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
