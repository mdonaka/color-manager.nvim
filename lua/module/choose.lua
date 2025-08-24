local M = {}

function M.choose_colorscheme_with_preview()
  local preview = require('module.preview')
  local util = require('module.util')
  preview.colorscheme_action_with_preview {
    prompt = "Choose Colorscheme> ",
    get_schemes_fn = util.get_colorscheme_names_and_paths,
    keep_last = true,
    on_select_fn = function(scheme, scheme_paths)
      if scheme then
        pcall(vim.cmd, "colorscheme " .. scheme)
        print("カラースキームを変更: " .. scheme)
      end
    end
  }
end

return M
