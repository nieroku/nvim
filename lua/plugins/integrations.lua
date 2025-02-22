return {
  {
    "christoomey/vim-tmux-navigator",
    cond = function()
      return os.getenv "TMUX" ~= nil
    end,
    keys = {
      { "<A-h>", "<Cmd>TmuxNavigateLeft<CR>" },
      { "<A-j>", "<Cmd>TmuxNavigateDown<CR>" },
      { "<A-k>", "<Cmd>TmuxNavigateUp<CR>" },
      { "<A-l>", "<Cmd>TmuxNavigateRight<CR>" },
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_save_on_switch = 0
    end,
  },
  {
    "ivanesmantovich/xkbswitch.nvim",
    cond = function()
      return vim.fn.executable "xkbswitch" == 1
    end,
    config = true,
  },
}
