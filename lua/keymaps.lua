vim.keymap.set("n", "<leader>q", "<Cmd>bdelete<CR>")
vim.keymap.set("n", "<leader>Q", "<Cmd>bdelete!<CR>")
vim.keymap.set(
  "n",
  "<leader><leader>",
  "<Cmd>Lazy<CR>",
  { desc = "Open plugins menu" }
)

vim.keymap.set("n", "<leader>cc", "<Cmd>cclose<CR>")
vim.keymap.set("n", "<leader>lc", "<Cmd>lclose<CR>")

vim.keymap.set("n", "<leader>t+", function()
  if vim.tbl_contains(vim.opt.clipboard, "unnamedplus") then
    vim.opt.clipboard:remove "unnamedplus"
  else
    vim.opt.clipboard:append "unnamedplus"
  end
  vim.notify(
    "clipboard=" .. vim.o.clipboard,
    vim.log.levels.INFO,
    { title = "Options" }
  )
end, { desc = "Toggle clipboard+=unnamedplus" })

local problems = {
  vim.diagnostic.severity.ERROR,
  vim.diagnostic.severity.WARN,
}
vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.setqflist()
end, { desc = "Add all diagnostics to quickfix list" })
vim.keymap.set("n", "<leader>p", function()
  vim.diagnostic.setqflist { title = "Problems", severity = problems }
end, { desc = "Add problems to quickfix list" })
vim.keymap.set("", "[d", function()
  vim.diagnostic.jump { count = -1 }
end, { desc = "Previous diagnostic" })
vim.keymap.set("", "]d", function()
  vim.diagnostic.jump { count = 1 }
end, { desc = "Next error or warning" })
vim.keymap.set("", "[p", function()
  vim.diagnostic.jump { count = -1, severity = problems }
end, { desc = "Previous error or warning" })
vim.keymap.set("", "]p", function()
  vim.diagnostic.jump { count = 1, severity = problems }
end, { desc = "Next error or warning" })

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "<F1>", "<lt>F1>")
