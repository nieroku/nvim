local keymap = require "keymap"

-- TODO: Refactor
return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2",
    name = "luasnip",
  },
  {
    "rafamadriz/friendly-snippets",
    name = "snippets",
    dependencies = { "luasnip" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "petertriho/cmp-git",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "luasnip",
      "snippets",
    },
    config = function()
      local luasnip = require "luasnip"
      local cmp = require "cmp"

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "async_path" },
        }, { { name = "buffer" }, { name = "async_path" } }),
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping(function(fallback)
            if luasnip.expandable() then
              luasnip.expand()
            elseif cmp.visible() then
              cmp.confirm { select = true }
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-Space>"] = cmp.mapping.confirm { select = true },
          -- TODO: Fix backspace in snippet selection
        },
      }
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources {
          { name = "cmp_git" },
          { name = "buffer" },
        },
      })
      for _, mode in ipairs { "/", "?" } do
        cmp.setup.cmdline(mode, { sources = { { name = "buffer" } } })
      end
    end,
  },
}
