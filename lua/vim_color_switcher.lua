local M = {}

local choose = require("module.choose")
local util = require("module.util")

-- 利用可能な.vimファイルからランダムにカラースキームを切り替える
function M.random_switch()
  local schemes = util.get_colorscheme_files()
  local pick = util.pick_random(schemes)
  vim.cmd.colorscheme(pick)
end

-- カラースキームを選択する
function M.choose_colorscheme()
  choose.choose_colorscheme_with_cpp_preview()
end

return M
