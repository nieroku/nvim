# Introduction

Here is my neovim configuration based on `lazy.nvim`. I'm using it for coding,
text editing, etc (for everything).

# Installation

This configuration can be installed using installation script that preserves old
configuration using git stash.

Run
[installation script](https://raw.githubusercontent.com/Nikitat0/nvim/main/install.sh)

- via wget

  ```
  wget https://raw.githubusercontent.com/Nikitat0/nvim/main/install.sh -qO - | sh
  ```

- via curl

  ```
  curl -s https://raw.githubusercontent.com/Nikitat0/nvim/main/install.sh | sh
  ```

or just `git clone` this repository to the Neovim configuration folder

## Requirements

- [Neovim](https://github.com/neovim/neovim) v0.9+
- git
- python3 with venv
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)

# Usage

## Updating

> TODO

## Shortcuts

`<leader>` key is Neovim default `\`.

|      Shortcut      | Action                               |
| :----------------: | :----------------------------------- |
|    `<leader>s`     | Unhighlight search results           |
|   `<leader><CR>`   | Run LSP code actions                 |
| `<leader><leader>` | List buffer symbols                  |
|      `<Tab>`       | Select buffer                        |
|    `<Tab><Tab>`    | Go to previous buffer                |
|      `<Tab>q`      | Close buffer                         |
|      `<Tab>Q`      | Force close buffer (even if unsaved) |
|       `<F1>`       | List help tags                       |
|       `<F2>`       | Rename (using LSP)                   |
|       `<F3>`       | Grep in files                        |
|       `<F4>`       | List files                           |
|   `<leader><F4>`   | List files with hidden               |
|       `<F5>`       | Format                               |
|   `<leader><F5>`   | Format (using LSP)                   |
|       `<F6>`       | Open current file directory          |
|   `<leader><F6>`   | Open current working directory       |
|       `<F7>`       | Show LSP hover                       |
|       `<F8>`       | Go to definition                     |
|   `<leader><F8>`   | Go to type definition                |
|      `<F10>`       | Open markdown preview                |
|      `<F11>`       | List diagnostics                     |
|  `<leader><F11>`   | List diagnostics in all buffers      |
|      `<F12>s`      | Toggle autosave (default: on)        |

## Tmux

> TODO
