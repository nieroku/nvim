local language_server = {}

function language_server:present()
  return vim.fn.executable(self.name or self.executable) == 1
end

function language_server:setup()
  require("lspconfig")[self.name].setup(self.opts or {})
end

local language_servers = {
  { name = "clangd", ft = { "c", "cpp" } },
  { name = "gopls", ft = { "go" } },
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
    name = "lspconfig",
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
      {
        "<F8>",
        function()
          require("telescope.builtins").lsp_definitions()
        end,
      },
      {
        "<leader><F8>",
        function()
          require("telescope.builtins").lsp_type_definitions()
        end,
      },
      {
        "<leader><leader>",
        function()
          require("telescope.builtins").lsp_document_symbols()
        end,
      },
      {
        "<F11>",
        function()
          require("telescope.builtins").diagnostics {
            bufnr = 0,
            severity_bound = "WARN",
          }
        end,
      },
      {
        "<leader><F11>",
        function()
          require("telescope.builtins").diagnostics { severity_bound = "WARN" }
        end,
      },
      { "<leader><CR>", vim.lsp.buf.code_action },
    },
    -- TODO: Lazy load language server
    config = function()
      for _, language_server in ipairs(language_server) do
        if language_server:present() then
          language_server:setup()
        end
      end
    end,
  },
}
