vim.keymap.set("n", "<leader>q", "<Cmd>bdelete<CR>")
vim.keymap.set("n", "<leader>Q", "<Cmd>bdelete!<CR>")
vim.keymap.set("n", "<leader><leader>", "<Cmd>Lazy<CR>")
vim.keymap.set("n", "<leader>cc", "<Cmd>cclose<CR>")
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
end)

vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "<F1>", "<lt>F1>")
