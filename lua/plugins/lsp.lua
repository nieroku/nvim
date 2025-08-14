return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              constantValues = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            staticcheck = nil,
            vulncheck = "Imports",
          },
        },
      })

      vim.lsp.inlay_hint.enable()

      vim.lsp.enable "gopls"
    end,
  },
}
