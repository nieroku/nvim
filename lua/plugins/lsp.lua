return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    keys = {
      { "<F2>", vim.lsp.buf.rename, desc = "Rename symbol" },
    },
    config = function()
      vim.lsp.inlay_hint.enable()

      vim.lsp.enable "clangd"
      vim.lsp.enable "gopls"
      vim.lsp.enable "mesonlsp"
      vim.lsp.enable "pyright"
      vim.lsp.enable "taplo"
      vim.lsp.enable "zls"
    end,
  },
}
