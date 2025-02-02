return {
  {
    "nvim-lualine/lualine.nvim",
    config = true,
  },
  "nvim-tree/nvim-web-devicons",
  {
    "stevearc/dressing.nvim",
    dependencies = "telescope",
    opts = {
      input = { insert_only = false },
    },
  },
}
