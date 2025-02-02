local options = {
  clipboard = "unnamedplus",
  cursorline = true,
  expandtab = true,
  fileencoding = "utf-8",
  hlsearch = true,
  mouse = "a",
  number = true,
  relativenumber = true,
  scrolloff = 999,
  shiftwidth = 4,
  tabstop = 4,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  undofile = true,
  writebackup = false,
  termguicolors = true,
  wrap = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd [[
augroup filetypedetect
  au! BufRead,BufNewFile *.nasm		setfiletype nasm
augroup END
]]
