local M = {}

-- ユーザーのconfig/colorsディレクトリ内の全ての.vimカラースキームファイルを取得する
function M.get_colorscheme_files()
  local dir = vim.fn.stdpath("config") .. "/colors/"
  local files = vim.fn.globpath(dir, "*.vim", false, true)
  local schemes = {}
  for _, f in ipairs(files) do
    local name = vim.fn.fnamemodify(f, ":t:r")
    table.insert(schemes, name)
  end
  return schemes
end

-- テーブルからランダムに1つ要素を選ぶ。空の場合はnilを返す
function M.pick_random(tbl)
  if #tbl == 0 then return nil end
  math.randomseed(os.time())
  return tbl[math.random(#tbl)]
end

return M
