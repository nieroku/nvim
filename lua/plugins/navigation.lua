return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    cmd = "FzfLua",
    keys = {
      { "<F1>", "<Cmd>FzfLua help_tags<CR>", desc = "Open Neovim Help" },
      { "<leader>h", "<Cmd>FzfLua help_tags<CR>", desc = "Open Neovim Help" },
      { "<leader>/", "<Cmd>FzfLua live_grep<CR>", desc = "Live grep" },
      {
        "<leader><CR>",
        "<Cmd>FzfLua global<CR>",
        desc = "Find file or LSP symbol",
      },
    },
    opts = function()
      local actions = require("fzf-lua").actions
      return {
        actions = {
          files = {
            ["default"] = actions.file_edit_or_qf,
            ["enter"] = actions.file_edit_or_qf,
            ["ctrl-f"] = {
              fn = actions.toggle_follow,
              reuse = true,
              header = false,
            },
            ["ctrl-h"] = {
              fn = actions.toggle_hidden,
              reuse = true,
              header = false,
            },
            ["ctrl-i"] = {
              fn = actions.toggle_ignore,
              reuse = true,
              header = false,
            },
          },
        },
        keymap = {
          builtin = {
            ["<F11>"] = "toggle-fullscreen",
          },
          fzf = {
            ["ctrl-q"] = "select-all+accept",
            ["ctrl-space"] = "toggle",
          },
        },
        -- Picker options
        files = {
          find_opts = [[-type f \!]]
            .. [[ -path '*/.git/*']]
            .. [[ -path '*/.direnv/*']],
          rg_opts = [[--color=never]]
            .. [[ --hidden]]
            .. [[ --files -g "!.git"]]
            .. [[ -g "!.direnv"]],
          fd_opts = [[--color=never]]
            .. [[ --hidden]]
            .. [[ --type f]]
            .. [[ --type l]]
            .. [[ --exclude .git]]
            .. [[ --exclude .direnv]],
        },
      }
    end,
    config = function(spec, opts)
      require("fzf-lua").setup(opts)
      require("fzf-lua").register_ui_select()

      vim.cmd [[
        au FileType fzf tnoremap <Tab> <C-j>
        au FileType fzf tnoremap <S-Tab> <C-k>
      ]]
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      {
        "<leader>o",
        function()
          require("oil").open()
        end,
        desc = "Open the current file's directory",
      },
      {
        "<leader>O",
        function()
          require("oil").open(vim.fn.getcwd())
        end,
        desc = "Open current working directory",
      },
    },
    opts = {
      view_options = {
        sort = { { "name", "asc" }, { "type", "asc" } },
      },
    },
  },
}
