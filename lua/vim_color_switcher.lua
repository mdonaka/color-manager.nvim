local M = {}

-- ユーザーのconfig/colorsディレクトリ内の全ての.vimカラースキームファイルを取得する
local function get_colorscheme_files()
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
local function pick_random(tbl)
  if #tbl == 0 then return nil end
  math.randomseed(os.time())
  return tbl[math.random(#tbl)]
end

-- 利用可能な.vimファイルからランダムにカラースキームを切り替える
function M.random_switch()
  local schemes = get_colorscheme_files()
  local pick = pick_random(schemes)
  vim.cmd.colorscheme(pick)
  print("Changed colorscheme to: " .. (pick or "none"))
end

-- カラースキームを選択する
local fzf = require("fzf-lua")
function M.choose_colorscheme()
  local schemes = get_colorscheme_files()
  require('fzf-lua').colorschemes({
    prompt = "Local Colorscheme> ",
    colors = schemes,
  })
end

return M
