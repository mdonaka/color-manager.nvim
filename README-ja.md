# vim-color-switcher
vim-color-switcherはVimのColor Schemaを管理するPluginです．
Color Schemaの選択，インストール，アンインストールを簡単に行うことができます．

![デモGIF](assets/demo.gif)

## インストール

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


## コマンド一覧

| コマンド                   | 説明                                                      |
|--------------------------|----------------------------------------------------------|
| `:ColorSwitcher`           | Color Schema選択UIを開き，Schameを切り替えます          |
| `:ColorSwitcherInstall`    | Color Schema選択UIを開き，Schameをインストールします |
| `:ColorSwitcherUninstall`  | Color Schema選択UIを開き，Schameをアンインストールします |

## 設定
| オプション                        | 型        | デフォルト                                    | 説明                                    |
|----------------------------------|----------|-----------------------------------------------|----------------------------------------|
| `colors_dir`                     | `string` | `vim.fn.stdpath("config") .. "/colors/"`      | カラースキームを格納するディレクトリ          |
| `randomize_colorscheme_on_startup`| `boolean`| `false`                                       | 起動時にランダムでカラースキームを適用       |

### lazy.nvim
```lua
{
  "mdonaka/vim-color-switcher",
  opts = {
    colors_dir = {string}
    randomize_colorscheme_on_startup = {boolean}
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


## ライセンス

MIT
