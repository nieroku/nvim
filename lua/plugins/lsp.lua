local keymap = require "keymap"

local language_server = {}

function language_server:present()
  return vim.fn.executable(self.name or self.executable) == 1
end

function language_server:setup(capabilities)
  local opts = self.opts or {}
  opts.capabilities = capabilities
  require("lspconfig")[self.name].setup(opts)
end

local language_servers = {
  { name = "clangd", ft = { "c", "cpp" } },
  { name = "gopls", ft = { "go" } },
  { name = "mesonlsp", ft = { "meson" } },
  { name = "pyright", ft = { "python" } },
  { name = "taplo", ft = { "toml" } },
  { name = "zls", ft = { "zig" } },
}

for i = 1, #language_servers do
  setmetatable(language_servers[i], { __index = language_server })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    ft = function(_, ft)
      for i = 1, #language_servers do
        language_server = language_servers[i]
        if language_server:present() then
          for i = 1, #language_server.ft do
            ft[#ft + 1] = language_server.ft[i]
          end
        end
      end
    end,
    keys = {
      { "<F2>", vim.lsp.buf.rename },
      { "<leader><F4>", vim.lsp.buf.format },
      { "<F7>", vim.lsp.buf.hover },
      { "<F8>" },
      { "<leader><F8>" },
      { "<F11>" },
      { "<leader><F11>" },
      { "<leader><leader>" },
      { "<leader><CR>", vim.lsp.buf.code_action },
    },
    config = function()
      local pickers = require "telescope.builtin"
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
          pickers.diagnostics { bufnr = nil, severity_bound = "WARN" }
        end,
      }

      -- TODO: Lazy load language server
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      for _, language_server in ipairs(language_servers) do
        if language_server:present() then
          language_server:setup(capabilities)
        end
      end
    end,
  },
}
