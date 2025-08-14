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
    "NMAC427/guess-indent.nvim",
    commit = "84a4987",
    opts = { auto_cmd = false },
    config = function(_, opts)
      local guess_indent = require "guess-indent"
      guess_indent.setup(opts)

      local augroup = vim.api.nvim_create_augroup("GuessIndent", {})
      local callback = function(event)
        guess_indent.set_from_buffer(event.buf, true, true)
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
      vim.api.nvim_create_autocmd("User", {
        group = augroup,
        desc = "Guess indentation when formatting a file",
        pattern = "FormatterPost",
        callback = callback,
      })
    end,
  },
  {
    "vladdoster/remember.nvim",
    config = function()
      require "remember"
    end,
  },
  {
    "klen/nvim-config-local",
    config = true,
  },
}
