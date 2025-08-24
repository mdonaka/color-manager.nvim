local M = {}


function M.uninstall_colorscheme_with_preview()
  local preview = require("module.preview")
  local options = require('module.config').options

  preview.colorscheme_action_with_preview {
    prompt = "Uninstall Colorscheme> ",
    dir = options.colors_dir,
    on_select_fn = function(scheme, scheme_paths)
      local target = scheme_paths[scheme]
      if target and vim.fn.filereadable(target) == 1 then
        local ok, err = pcall(vim.fn.delete, target)
        if ok and err == 0 then
          print("アンインストール完了: " .. target)
        else
          print("アンインストール失敗: " .. target)
        end
      end
    end
  }
end

return M
