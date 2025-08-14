local options = {
  clipboard = "unnamedplus",
  cursorline = true,
  expandtab = true,
  fileencoding = "utf-8",
  foldlevelstart = 99,
  hlsearch = true,
  mouse = "r",
  number = true,
  relativenumber = true,
  scrolloff = 999,
  shiftwidth = 2,
  showtabline = 0,
  softtabstop = 2,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  timeoutlen = 500,
  undofile = true,
  wrap = true,
  writebackup = false,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd [[
au FileType help setlocal tabstop=8
au TermOpen * setlocal tabstop=8

augroup filetypedetect
  au! BufRead,BufNewFile *.nasm setfiletype nasm
augroup END
]]
