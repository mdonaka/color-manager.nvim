local M = {}

M.options = require("module.config").options
local random = require("module.random")

--- モジュールのセットアップを行う
-- @function M.setup
-- @param opts (table) 設定オプションテーブル。M.options の各項目を上書きする。
-- @desc
--   - 渡された opts の内容で M.options を上書きします。
--   - 起動時にカラースキームのランダム適用を試みます（random.pick_random()）。
--   - colors_dir の親ディレクトリを runtimepath に追加します。
function M.setup(opts)
  opts = opts or {}
  for k, v in pairs(opts) do
    M.options[k] = v
  end
  random.pick_random()
  vim.opt.rtp:append(vim.fn.fnamemodify(M.options.colors_dir, ":h"))
end

return M
