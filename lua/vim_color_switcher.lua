local M = {}

-- ユーザーのconfig/colorsディレクトリ内の全ての.vimカラースキームファイルを取得する
local function get_colorscheme_files()
  local dir = vim.fn.stdpath("config") .. "/colors/"
  return vim.fn.globpath(dir, "*.vim", false, true)
end

-- テーブルからランダムに1つ要素を選ぶ。空の場合はnilを返す
local function pick_random(tbl)
  if #tbl == 0 then return nil end
  math.randomseed(os.time())
  return tbl[math.random(#tbl)]
end

-- 利用可能な.vimファイルからランダムにカラースキームを切り替える
function M.random_switch()
  local files = get_colorscheme_files()
  local pick = pick_random(files)
  if not pick then return end
  local name = vim.fn.fnamemodify(pick, ":t:r")
  vim.cmd.colorscheme(name)
  print("Changed colorscheme to: " .. name)
end

-- カラースキームを選択する
local fzf = require("fzf-lua")
function M.choose_colorscheme()
  local files = get_colorscheme_files()
  local schemes = {}
  for _, f in ipairs(files) do
    local name = vim.fn.fnamemodify(f, ":t:r")
    table.insert(schemes, name)
  end

  fzf.fzf_exec(schemes, {
    prompt = "Local Colorscheme> ",
    actions = {
      ["default"] = function(selected)
        if selected and selected[1] then
          vim.cmd.colorscheme(selected[1])
        end
      end,
    },
  })
end

function M.choose_colorscheme()
  local files = get_colorscheme_files()
  local schemes = {}
  for _, f in ipairs(files) do
    local name = vim.fn.fnamemodify(f, ":t:r")
    table.insert(schemes, name)
  end

  require('fzf-lua').colorschemes({
    prompt = "Local Colorscheme> ",
    colors = schemes,
  })
end

return M
