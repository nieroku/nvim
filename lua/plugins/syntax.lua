return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = true },
      }

      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.o.foldlevelstart = 99
    end,
  },
}
