local M = {}


--- カラースキームをランダムに選んで適用する
-- @function M.pick_random
-- @desc
--   module.config.options.randomize_colorscheme_on_startup が true の場合のみ有効。
--   options.colors_dir にあるカラースキームから1つランダム選択して :colorscheme で適用する。
--   カラースキームが0件の場合や設定が無効な場合は何もしない。
-- @return nil 常にnilを返す
function M.pick_random()
  local options = require("module.config").options
  if options.randomize_colorscheme_on_startup == false then
    return nil
  end

  local util = require("module.util")
  local tbl, _ = util.get_schemes_from_dir(options.colors_dir)
  if #tbl == 0 then return nil end
  math.randomseed(os.time())
  vim.cmd.colorscheme(tbl[math.random(#tbl)])
end

return M
