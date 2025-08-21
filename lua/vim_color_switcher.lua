local M = {}

local choose = require("module.choose")
local util = require("module.util")
local install = require("module.install")

-- 利用可能な.vimファイルからランダムにカラースキームを切り替える
function M.random_switch()
  local schemes = util.get_colorscheme_files()
  local pick = util.pick_random(schemes)
  vim.cmd.colorscheme(pick)
end

-- カラースキームを選択する
function M.choose_colorscheme()
  choose.choose_colorscheme_with_preview()
end

-- カラースキームをインストールする
function M.install_colorscheme()
  install.pick_and_install_with_preview()
end

return M
