local keymap = require "keymap"

return {
  {
    "williamboman/mason-lspconfig.nvim",
    init = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers {
        function(server)
          require("lspconfig")[server].setup {}
        end,
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    dependencies = { "telescope" },
    init = function()
      local pickers = require "telescope.builtin"

      keymap { "<F2>", vim.lsp.buf.rename }
      keymap { "<leader><F4>", vim.lsp.buf.format }
      keymap { "<F7>", vim.lsp.buf.hover }
      keymap { "<F8>", pickers.lsp_definitions }
      keymap { "<leader><F8>", pickers.lsp_type_definitions }
      keymap { "<leader><leader>", pickers.lsp_document_symbols }
      keymap {
        "<F11>",
        function()
          pickers.diagnostics { bufnr = 0, severity_bound = "WARN" }
        end,
      }
      keymap {
        "<leader><F11>",
        function()
          pickers.diagnostics { severity_bound = "WARN" }
        end,
      }
      keymap { "<leader><CR>", vim.lsp.buf.code_action }
    end,
  },
}
