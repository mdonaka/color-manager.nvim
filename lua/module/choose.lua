local M = {}

local random = require('module.random')
local api = vim.api
local preview = require('module.preview')

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

function M.choose_colorscheme_with_preview()
  local opts = calc_opts()
  local preview_buf, preview_win = preview.open_float_preview(opts)
  local schemas = random.get_colorscheme_files()
  local original_scheme = vim.g.colors_name
  local _last_preview = nil

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
    on_move = function(selected)
      if selected and selected[1] and _last_preview ~= selected[1] then
        pcall(vim.cmd, "colorscheme " .. selected[1])
        _last_preview = selected[1]
      end
    end,
    actions = {
      ['default'] = function(selected, _)
        if preview_win then pcall(api.nvim_win_close, preview_win, true) end
        vim.cmd("colorscheme " .. selected[1])
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
