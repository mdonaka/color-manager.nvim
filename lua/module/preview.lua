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

function M.colorscheme_action_with_preview(opts)
  local prompt = opts.prompt or "Colorscheme> "
  local get_schemes_fn = opts.get_schemes_fn
  local on_select_fn = opts.on_select_fn

  local ui_opts = calc_opts()
  local preview_buf, preview_win = M.open_float_preview(ui_opts)
  local schemes, scheme_paths = get_schemes_fn()
  local original_scheme = vim.g.colors_name
  local _last_preview = nil

  require('fzf-lua').colorschemes({
    prompt = prompt,
    colors = schemes,
    winopts = {
      width = ui_opts.fzf_width,
      height = ui_opts.height,
      row = ui_opts.row,
      col = ui_opts.fzf_col,
      preview = { hidden = true },
      border = "rounded",
    },
    on_move = function(selected)
      if selected and selected[1] and _last_preview ~= selected[1] then
        pcall(vim.cmd, "colorscheme " .. selected[1])
        _last_preview = selected[1]
      end
    end,
    actions = {
      ['default'] = function(selected, _)
        if preview_win then pcall(api.nvim_win_close, preview_win, true) end
        if selected and selected[1] then
          on_select_fn(selected[1], scheme_paths, preview_win, preview_buf)
        end
        if not opts.keep_last then
          if original_scheme then
            pcall(vim.cmd, "colorscheme " .. original_scheme)
          end
        end
      end,
      ['esc'] = function(_, _)
        if preview_win then pcall(api.nvim_win_close, preview_win, true) end
        if original_scheme then
          pcall(vim.cmd, "colorscheme " .. original_scheme)
        end
      end,
      ['ctrl-c'] = function(_, _)
        if preview_win then pcall(api.nvim_win_close, preview_win, true) end
        if original_scheme then
          pcall(vim.cmd, "colorscheme " .. original_scheme)
        end
      end,
    }
  })
end

return M
