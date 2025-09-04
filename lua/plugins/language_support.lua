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
      vim.lsp.config("lua_ls", {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath "config" then
              return
            end
          end

          client.config.settings.Lua =
            vim.tbl_deep_extend("force", client.config.settings.Lua, {
              runtime = {
                version = "LuaJIT",
                path = {
                  "lua/?.lua",
                  "lua/?/init.lua",
                },
              },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
              },
            })
        end,
        settings = { Lua = {} },
      })

      vim.lsp.inlay_hint.enable()

      vim.lsp.enable "clangd"
      vim.lsp.enable "gopls"
      vim.lsp.enable "lua_ls"
    end,
  },
  {
    "scalameta/nvim-metals",
    ft = { "sbt", "scala" },
    init = function()
      vim.opt_global.shortmess:remove "F"
    end,
    opts = function()
      local opts = require("metals").bare_config()
      opts.init_options.statusBarProvider = "off"
      return opts
    end,
    config = function(self, opts)
      local nvim_metals_group =
        vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(opts)
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
