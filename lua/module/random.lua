local M = {}


-- テーブルからランダムに1つ要素を選ぶ。空の場合はnilを返す
function M.pick_random()
  local options = require("module.config").options
  if options.randomize_colorscheme_on_startup == false then
    return nil
  end

  local util = require("module.util")
  local tbl, _ = util.get_colorscheme_names_and_paths()
  if #tbl == 0 then return nil end
  math.randomseed(os.time())
  vim.cmd.colorscheme(tbl[math.random(#tbl)])
end

return M
