local M = {}
local api = vim.api

M.preview_lines = {
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

function M.close_existing_preview_buf()
  for _, buf in ipairs(api.nvim_list_bufs()) do
    if api.nvim_buf_get_name(buf):match("preview%.lua$") then
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

function M.open_float_preview(opts)
  M.close_existing_preview_buf()
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
  api.nvim_buf_set_option(buf, 'filetype', 'lua')
  api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  api.nvim_buf_set_name(buf, "preview.lua")
  api.nvim_buf_set_option(buf, 'modifiable', false)
  -- サンプルコードを書き込む
  api.nvim_buf_set_option(buf, 'modifiable', true)
  api.nvim_buf_set_lines(buf, 0, -1, false, M.preview_lines)
  api.nvim_buf_set_option(buf, 'modifiable', false)
  return buf, win
end

return M
