local M = {}

function M.choose_colorscheme_with_preview()
  local preview = require('module.preview')
  local options = require('module.config').options

  preview.colorscheme_action_with_preview {
    prompt = "Choose Colorscheme> ",
    dir = options.colors_dir,
    keep_last = true,
    on_select_fn = function(scheme, _)
      if scheme then
        pcall(vim.cmd, "colorscheme " .. scheme)
        print("カラースキームを変更: " .. scheme)
      end
    end
  }
end

return M
