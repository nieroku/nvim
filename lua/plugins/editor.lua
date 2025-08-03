return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "pocco81/auto-save.nvim",
    lazy = false,
    keys = {
      { "<F12>s", "<Cmd>ASToggle<CR>" },
    },
    opts = {
      condition = function(buf)
        return not string.match(vim.api.nvim_buf_get_name(buf), "oil://")
      end,
    },
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      ignore = "^(%s*)$",
      mappings = {
        basic = true,
        extra = true,
      },
    },
  },
  {
    "vladdoster/remember.nvim",
    config = function()
      require "remember"
    end,
  },
}
