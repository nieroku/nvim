local on_tab_insert = function(fallback)
  fallback()
end

local on_ctrl_j_insert = function(fallback)
  fallback()
end

return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      map_c_h = true,
      map_c_w = true,
    },
  },

  {
    "L3MON4D3/LuaSnip",
    version = "^2",
    dependencies = { "rafamadriz/friendly-snippets" },
    lazy = true,
    config = function(_, opts)
      require("luasnip").setup(opts)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "petertriho/cmp-git",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function(_, opts)
          require("cmp_git").setup(opts)
        end,
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        init = function()
          vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,
      },
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "https://codeberg.org/FelipeLema/cmp-async-path.git",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "windwp/nvim-autopairs",
    },
    event = { "CmdlineEnter", "InsertEnter" },
    config = function()
      local cmp = require "cmp"
      local lspkind = require "lspkind"
      local luasnip = require "luasnip"

      local function should_complete()
        local line = vim.api.nvim_get_current_line()
        local _, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and line:sub(col, col):match "%s" == nil
      end
      local select_next_item = function()
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      end
      local select_prev_item = function()
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
      end
      local tab_insert_mapping = function(fallback)
        if cmp.visible() then
          select_next_item()
        elseif luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        elseif should_complete() and not luasnip.in_snippet() then
          cmp.complete()
          select_next_item()
        else
          fallback()
        end
      end
      local shift_tab_insert_mapping = function(fallback)
        if cmp.visible() then
          select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end
      local mapping = {
        ["<Tab>"] = cmp.mapping {
          i = function(fallback)
            on_tab_insert(function()
              tab_insert_mapping(fallback)
            end)
          end,
          s = tab_insert_mapping,
          c = function(fallback)
            if not cmp.visible() then
              cmp.complete()
            end
            select_next_item()
          end,
        },
        ["<C-j>"] = cmp.mapping {
          i = function(fallback)
            on_ctrl_j_insert(function()
              if cmp.visible() then
                select_next_item()
              elseif should_complete() then
                cmp.complete()
                select_next_item()
              else
                fallback()
              end
            end)
          end,
          c = function()
            if cmp.visible() then
              select_next_item()
            else
              cmp.complete()
              select_next_item()
            end
          end,
        },
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<S-Tab>"] = cmp.mapping {
          i = shift_tab_insert_mapping,
          s = shift_tab_insert_mapping,
          c = function(fallback)
            if cmp.visible() then
              select_prev_item()
            else
              fallback()
            end
          end,
        },
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            select_prev_item()
          else
            fallback()
          end
        end, { "i", "c" }),

        ["<C-u>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.scroll_docs(-4)
          else
            fallback()
          end
        end, { "i", "c" }),
        ["<C-d>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.scroll_docs(4)
          else
            fallback()
          end
        end, { "i", "c" }),
        ["<BS>"] = cmp.mapping {
          s = function()
            local enter_insert_mode =
              vim.api.nvim_replace_termcodes('<C-o>"_c', true, true, true)
            vim.api.nvim_feedkeys(enter_insert_mode, "n", false)
          end,
        },

        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm { select = false }
          else
            fallback()
          end
        end, { "i", "c" }),
        ["<C-c>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c" }),
      }

      cmp.setup {
        completion = { autocomplete = false },
        mapping = mapping,
        performance = { max_view_entries = 16 },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources {
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "async_path", option = { trailing_slash = true } },
        },

        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            local item = require("lspkind").cmp_format {
              mode = "symbol",

              ellipsis_char = "...",
              maxwidth = 32,
              menu = {
                async_path = "[Path]",
                buffer = "[Buffer]",
                cmdline = "[Cmdline]",
                luasnip = "[LuaSnip]",
                nvim_lsp = "[LSP]",
              },
            }(entry, vim_item)
            item.kind = " " .. item.kind .. " "
            return item
          end,
        },
        view = { entries = { selection_order = "near_cursor" } },
        window = {
          completion = {
            col_offset = -3,
            side_padding = 0,
          },
        },
      }

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline(":", {
        mapping = mapping,
        sources = {
          { name = "async_path", option = { trailing_slash = true } },
          { name = "cmdline" },
        },
      })

      cmp.event:on(
        "confirm_done",
        require("nvim-autopairs.completion.cmp").on_confirm_done()
      )
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    keys = {
      { "<leader>tc", desc = "Toggle Copilot" },
    },
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        trigger_on_accept = false,
        keymap = {
          accept_word = false,
          accept_line = false,
          accept = "<C-a>",
          next = "<C-n>",
          prev = "<C-p>",
          dismiss = "<C-]>",
        },
      },
    },
    config = function(_, opts)
      local copilot = require "copilot"
      local client = require "copilot.client"
      local command = require "copilot.command"
      local suggestion = require "copilot.suggestion"

      copilot.setup(opts)

      local cmp = require "cmp"
      cmp.event:on("menu_opened", function()
        vim.b.copilot_suggestion_hidden = true
        suggestion.dismiss()
      end)
      cmp.event:on("menu_closed", function()
        vim.b.copilot_suggestion_hidden = false
      end)

      local function accept_word(suggestion)
        local range, text = suggestion.range, suggestion.text
        local _, col = unpack(vim.api.nvim_win_get_cursor(0))
        local _, until_pos =
          text:find("%s*[\\.:]*[^%s\\.,:;]*[,;]?%s*", col + 1)
        suggestion.partial_text = text:sub(1, until_pos)
        range["end"].character = until_pos
        range["end"].line = range["start"].line
        return suggestion
      end
      on_tab_insert = function(fallback)
        if suggestion.is_visible() then
          suggestion.accept(accept_word)
        else
          fallback()
        end
      end
      on_ctrl_j_insert = function(fallback)
        if suggestion.is_visible() then
          suggestion.accept_line()
        else
          fallback()
        end
      end

      vim.keymap.set("n", "<leader>tc", function()
        vim.keymap.set("n", "<leader>tc", function()
          if client.is_disabled() then
            command.enable()
            client.buf_attach()
          else
            command.disable()
          end
        end, { desc = "Enable/disable Copilot" })
      end)

      vim.g.copilot_loaded = true
      client.buf_attach()
    end,
  },
}
