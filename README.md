# vim-color-switcher
vim-color-switcher is a plugin for managing Color Schemes in Vim.  
It allows you to easily select, install, and uninstall color schemes.

![Demo GIF](assets/demo.gif)

## Installation

### lazy.nvim

```lua
{
  "mdonaka/vim-color-switcher",
}
```

### vim-plug

```vim
Plug 'mdonaka/vim-color-switcher'
```

## Commands

| Command                    | Description                                                            |
|----------------------------|------------------------------------------------------------------------|
| `:ColorSwitcher`           | Opens the color scheme selection UI and switches a scheme            |
| `:ColorSwitcherInstall`    | Opens the color scheme selection UI and installs a color scheme          |
| `:ColorSwitcherUninstall`  | Opens the color scheme selection UI and uninstalls a color scheme        |

## Configuration

| Option                          | Type      | Default                                      | Description                                   |
|----------------------------------|-----------|----------------------------------------------|-----------------------------------------------|
| `colors_dir`                     | `string`  | `vim.fn.stdpath("config") .. "/colors/"`     | Directory to store color schemes              |
| `randomize_colorscheme_on_startup`| `boolean` | `false`                                      | Apply a random color scheme on startup        |

### lazy.nvim
```lua
{
  "mdonaka/vim-color-switcher",
  opts = {
    colors_dir = {string},
    randomize_colorscheme_on_startup = {boolean},
  }
}
```
### vim-plug
```vim
Plug 'mdonaka/vim-color-switcher'
lua << EOF
require("vim-color-switcher").setup({
  colors_dir = {string},
  randomize_colorscheme_on_startup = {boolean},
})
EOF
```

## License

MIT
