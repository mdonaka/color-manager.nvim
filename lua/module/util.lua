local M = {}


-- ユーザーのconfig/colorsディレクトリ内の全ての.vimカラースキームファイル名とパスを返す
function M.get_colorscheme_names_and_paths()
  local options = require("module.config").options
  local dir = options.colors_dir
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
