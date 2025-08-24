local M = {}

-- 共通: 指定ディレクトリからカラースキーム名リストとパスのテーブルを取得
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
