return {
  "mhartington/formatter.nvim",
  cmd = { "Format", "FormatWrite", "FormatLock", "FormatWriteLock" },
  keys = { { "<F5>", "<Cmd>FormatWrite<CR>" } },
  config = function()
    require("formatter").setup {
      logging = true,
      filetype = {
        c = { require("formatter.filetypes.c").clangformat },
        cpp = { require("formatter.filetypes.cpp").clangformat },
        css = { require("formatter.filetypes.css").prettierd },
        go = {
          function()
            return {
              exe = "gofmt",
              args = { "-s" },
              stdin = true,
            }
          end,
        },
        html = { require("formatter.filetypes.html").prettierd },
        java = { require("formatter.filetypes.java").google_java_format },
        javascript = { require("formatter.filetypes.javascript").prettierd },
        json = { require("formatter.filetypes.json").prettierd },
        lua = { require("formatter.filetypes.lua").stylua },
        markdown = { require("formatter.filetypes.markdown").prettierd },
        nix = { require("formatter.filetypes.nix").nixpkgs_fmt },
        python = { require("formatter.filetypes.python").autopep8 },
        yaml = { require("formatter.filetypes.yaml").prettierd },
        ["*"] = {
          function()
            if vim.bo.filetype ~= "markdown" then
              require("formatter.filetypes.any").substitute_trailing_whitespace()
            end
          end,
        },
      },
    }
  end,
}
