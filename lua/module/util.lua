local M = {}

--- 指定ディレクトリ内の .vim カラースキームファイル一覧を取得する
-- @function M.get_schemes_from_dir
-- @param dir (string) 検索対象ディレクトリのパス
-- @return names (table) カラースキーム名（ファイル名拡張子抜き）の配列
-- @return paths (table) names の各カラースキーム名をキー、ファイルパスを値としたテーブル
-- @desc
--   指定したディレクトリ内の .vim ファイルを全て走査し、
--   ファイル名（拡張子なし）リストと、そのファイル名からファイルパスへのマップテーブルを返します。
function M.get_schemes_from_dir(dir)
  local files = vim.fn.globpath(dir, "*.vim", false, true)
  local names = {}
  local paths = {}
  for _, f in ipairs(files) do
    local name = vim.fn.fnamemodify(f, ":t:r")
    table.insert(names, name)
    paths[name] = f
  end
  return names, paths
end

return M
