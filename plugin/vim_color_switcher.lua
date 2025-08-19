local mod = require("vim_color_switcher")

-- 起動時にランダムにカラースキーマを変更
mod.random_switch()

-- :ColorSwitchコマンドを追加
vim.api.nvim_create_user_command("ColorSwitch", function() mod.choose_colorscheme() end, {})
