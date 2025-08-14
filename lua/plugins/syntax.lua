local on_buffer_format = function(buf) end

return {
  { "numToStr/Comment.nvim", opts = { ignore = "^(%s*)$" } },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      incremental_selection = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  },

  {
    "NMAC427/guess-indent.nvim",
    commit = "84a4987",
    opts = { auto_cmd = false },
    config = function(_, opts)
      local guess_indent = require "guess-indent"
      guess_indent.setup(opts)
      vim.api.nvim_del_user_command "GuessIndent"

      on_buffer_format = function(buf)
        guess_indent.set_from_buffer(buf, true, true)
      end

      local augroup = vim.api.nvim_create_augroup("GuessIndent", {})
      local callback = function(event)
        on_buffer_format(event.buf)
      end
      vim.api.nvim_create_autocmd("BufReadPost", {
        group = augroup,
        desc = "Guess indentation when loading a file",
        callback = callback,
      })
      vim.api.nvim_create_autocmd("BufNewFile", {
        group = augroup,
        desc = "Guess indentation when saving a new file",
        callback = function(event)
          vim.api.nvim_create_autocmd("BufWritePost", {
            group = augroup,
            buffer = event.buf,
            callback = callback,
            once = true,
          })
        end,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          local buf = vim.api.nvim_get_current_buf()
          require("conform").format({ async = true }, function(err, did_edit)
            if err == nil and did_edit then
              on_buffer_format(buf)
            end
          end)
        end,
        desc = "Format buffer",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        css = { "prettierd", "prettier" },
        go = { "gofumpt", "gofmt" },
        html = { "prettierd", "prettier" },
        javascript = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        lua = { "stylua" },
        markdown = { "prettierd", "prettier" },
        nix = { "nixpkgs_fmt" },
        python = { "autopep8" },
        yaml = { "prettierd", "prettier" },
        ["_"] = { "trim_newlines", "trim_whitespace", stop_after_first = false },
      },
      default_format_opts = {
        lsp_format = "fallback",
        stop_after_first = true,
      },
    },
  },
}
