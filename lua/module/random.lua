local M = {}

local options = require("module.config").options

-- ユーザーのconfig/colorsディレクトリ内の全ての.vimカラースキームファイルを取得する
function M.get_colorscheme_files()
  local dir = options.colors_dir
  local files = vim.fn.globpath(dir, "*.vim", false, true)
  local schemes = {}
  for _, f in ipairs(files) do
    local name = vim.fn.fnamemodify(f, ":t:r")
    table.insert(schemes, name)
  end
  return schemes
end

-- テーブルからランダムに1つ要素を選ぶ。空の場合はnilを返す
function M.pick_random()
  if options.randomize_colorscheme_on_startup == false then
    return nil
  end

  local tbl = M.get_colorscheme_files()
  if #tbl == 0 then return nil end
  math.randomseed(os.time())
  vim.cmd.colorscheme(tbl[math.random(#tbl)])
end

return M
