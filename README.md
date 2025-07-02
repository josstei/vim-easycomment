![Stable](https://img.shields.io/badge/status-under_development-orange) ![License](https://img.shields.io/badge/license-MIT-blue)
# vim-easycomment

A minimal, pure-Vimscript plugin to quickly (un)comment lines or blocks of code in Vim/Neovim.

---

## Features

- Toggle comments on the current line or a visual selection with a single command.
- Automatically uses the correct comment string for supported languages.
- Indentation-preserving: comments are inserted after leading whitespace.
- Pure Vimscript; no dependencies.

---

## Installation

Use your favorite plugin manager. Example for [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'josstei/vim-easycomment'
```

Reload and run `:PlugInstall`.

---

## Usage

### Command

- `:EasyComment`
    - In normal mode: Comments/uncomments the current line.
    - In visual mode: Comments/uncomments the selected block.

For convenience, map it to a key in your vimrc:

```vim
" Toggle comment for the current line
nnoremap <leader>c :EasyComment<CR>
" Toggle comment for selection
vnoremap <leader>c :EasyComment<CR>
```

### How It Works

- The plugin detects the filetype and uses the appropriate comment string.
- If all non-blank lines in the range are already commented, they’ll be uncommented; otherwise, they’ll be commented.
- Comments are applied after leading whitespace, preserving code indentation.

---

## Supported Languages

Out-of-the-box support for:
- Vim (`"`)
- Shell (`#`)
- C/C++/Java/Scala (`//`)

---

## Example

Given this C code:

```c
int main() {
    printf("Hello world\n");
}
```

Visually select the lines and run `:EasyComment` (or use your mapping):

```c
// int main() {
//     printf("Hello world\n");
// }
```

Run again to uncomment.

---

## License

MIT License (see [LICENSE](LICENSE) for details).

---
