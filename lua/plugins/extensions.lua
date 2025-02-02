return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      {
        "<F6>",
        function()
          require("oil").open()
        end,
      },
      {
        "<leader><F6>",
        function()
          require("oil").open(vim.fn.getcwd())
        end,
      },
    },
    opts = {
      view_options = {
        sort = { { "name", "asc" }, { "type", "asc" } },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    branch = "0.1.x",
    name = "telescope",
    keys = {
      {
        "<F1>",
        function()
          require("telescope.builtin").help_tags()
        end,
      },
      {
        "<F3>",
        function()
          require("telescope.builtin").live_grep()
        end,
      },
      {
        "<F4>",
        function()
          require("telescope.builtin").find_files()
        end,
      },
      {
        "<leader><F4>",
        function()
          require("telescope.builtin").find_files { hidden = true }
        end,
      },
      {
        "<Tab><Tab>",
        function()
          require("telescope.builtin").buffers {
            ignore_current_buffer = true,
            sort_mru = true,
          }
        end,
      },
    },
  },
}
