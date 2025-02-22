local keymap = require "keymap"

keymap { "<leader>s", "<Cmd>nohlsearch<CR>" }
keymap { "<Tab>q", "<Cmd>bdelete<CR>" }
keymap { "<Tab>Q", "<Cmd>bdelete!<CR>" }
keymap { "<F12>p", "<Cmd>Lazy<CR>" }
keymap { "jk", "<Esc>", mode = "i" }
