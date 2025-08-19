local M = {}

local util = require('module.util')
local api = vim.api

local cpp_code = {
  "#include <iostream>",
  "",
  "int fibonacci(int n) {",
  "    if (n <= 1) return n;",
  "    return fibonacci(n - 1) + fibonacci(n - 2);",
  "}",
  "",
  "int main() {",
  "    for (int i = 0; i < 10; ++i) {",
  "        std::cout << fibonacci(i) << \" \";",
  "    }",
  "    std::cout << std::endl;",
  "    return 0;",
  "}",
}

-- 既存のプレビューバッファとウィンドウを閉じる
local function close_existing_preview_buf()
  for _, buf in ipairs(api.nvim_list_bufs()) do
    if api.nvim_buf_get_name(buf):match("preview%.cpp$") then
      if api.nvim_buf_is_loaded(buf) then
        for _, win in ipairs(api.nvim_list_wins()) do
          if api.nvim_win_get_buf(win) == buf then
            pcall(api.nvim_win_close, win, true)
          end
        end
        api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
end

-- 浮動ウィンドウでプレビューバッファを開く
local function open_float_preview(opts)
  close_existing_preview_buf()
  local buf = api.nvim_create_buf(false, true)
  local win = api.nvim_open_win(buf, false, {
    relative = "editor",
    width = opts.preview_width,
    height = opts.height,
    row = opts.row,
    col = opts.preview_col,
    style = "minimal",
    border = "rounded",
    focusable = false,
    zindex = 60
  })
  api.nvim_buf_set_option(buf, 'filetype', 'cpp')
  api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  api.nvim_buf_set_name(buf, "preview.cpp")
  api.nvim_buf_set_option(buf, 'modifiable', false)
  return buf, win
end

-- プレビューバッファにC++コードを書き込む
local function write_cpp_code(buf)
  api.nvim_buf_set_option(buf, 'modifiable', true)
  api.nvim_buf_set_lines(buf, 0, -1, false, cpp_code)
  api.nvim_buf_set_option(buf, 'modifiable', false)
end

-- optsの計算を関数化
-- 2つのウィンドウの位置・サイズ情報を返す
local function calc_opts()
  local total_lines = vim.o.lines
  local total_columns = vim.o.columns

  local height = math.floor(total_lines * 0.4)
  local fzf_width = math.floor(total_columns * 0.24)
  local preview_width = math.floor(total_columns * 0.345)
  local total_width = fzf_width + preview_width

  local row = math.floor((total_lines - height) / 2)
  local col_center = math.floor((total_columns - total_width) / 2)
  local fzf_col = col_center
  local preview_col = col_center + fzf_width

  return {
    row = row,
    height = height,
    fzf_col = fzf_col,
    preview_col = preview_col,
    fzf_width = fzf_width,
    preview_width = preview_width,
  }
end

-- fzf-luaのカラースキーム選択とC++プレビューウィンドウを中央に横並びで表示
function M.choose_colorscheme_with_cpp_preview()
  local opts = calc_opts()
  local preview_buf, preview_win = open_float_preview(opts)
  write_cpp_code(preview_buf)

  local schemas = util.get_colorscheme_files()

  require('fzf-lua').colorschemes({
    prompt = "Local Colorscheme> ",
    colors = schemas,
    winopts = {
      width = opts.fzf_width,
      height = opts.height,
      row = opts.row,
      col = opts.fzf_col,
      preview = { hidden = true },
      border = "rounded",
    },
    actions = {
      ['default'] = function(selected, _)
        pcall(api.nvim_win_close, preview_win, true)
        vim.cmd("colorscheme " .. selected[1])
      end,
      ['esc'] = function(_, _)
        pcall(api.nvim_win_close, preview_win, true)
      end,
    }
  })
end

return M
