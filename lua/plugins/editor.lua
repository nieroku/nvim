return {
  {
    "okuuva/auto-save.nvim",
    lazy = false,
    keys = {
      { "<leader>ts", "<Cmd>ASToggle<CR>", desc = "Toggle autosave" },
    },
    opts = {
      condition = function(buf)
        return vim.fn.getbufvar(buf, "&filetype") ~= "oil"
      end,
    },
    config = function(spec, opts)
      require("auto-save").setup(opts)

      local group = vim.api.nvim_create_augroup("autosave", {})

      vim.api.nvim_create_autocmd("User", {
        pattern = { "AutoSaveEnable", "AutoSaveDisable" },
        group = group,
        callback = function(event)
          local msg = "Disabled"
          if event.match == "AutoSaveEnable" then
            msg = "Enabled"
          end
          vim.notify(msg, vim.log.levels.INFO, { title = "auto-save.nvim" })
        end,
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      ignore = "^(%s*)$",
      mappings = {
        basic = true,
        extra = true,
      },
    },
  },
  {
    "vladdoster/remember.nvim",
    config = function()
      require "remember"
    end,
  },
}
