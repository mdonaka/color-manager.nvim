local M = {}

M.options = {
  colors_dir = vim.fn.stdpath("config") .. "/colors/", -- カラースキームファイルのディレクトリ
  randomize_colorscheme_on_startup = false,            -- 起動時ランダムカラースキーム（有効/無効）
}

return M
