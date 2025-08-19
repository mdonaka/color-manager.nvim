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
function M.switch()
  local files = get_colorscheme_files()
  local pick = pick_random(files)
  if not pick then return end
  local name = vim.fn.fnamemodify(pick, ":t:r")
  vim.cmd.colorscheme(name)
  print("Changed colorscheme to: " .. name)
end

-- Neovimに:ColorSwitchユーザーコマンドを作成する
vim.api.nvim_create_user_command("ColorSwitch", function() M.switch() end, {})

return M
