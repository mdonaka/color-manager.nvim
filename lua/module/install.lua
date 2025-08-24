local M = {}


function M.pick_and_install_with_preview()
  local preview = require("module.preview")
  local opsions = require("module.config").options

  preview.colorscheme_action_with_preview {
    prompt = "Awesome Colorscheme> ",
    dir = vim.fn.stdpath("data") .. "/lazy/awesome-vim-colorschemes/colors/",

    on_select_fn = function(scheme, scheme_paths)
      local src = scheme_paths[scheme]
      if src then
        local dest = opsions.colors_dir .. vim.fn.fnamemodify(src, ":t")
        local cp_result = vim.fn.system({ 'cp', src, dest })
        if vim.v.shell_error ~= 0 then
          print("ファイルコピー失敗: " .. dest .. " : " .. vim.inspect(cp_result))
        else
          print("インストール完了: " .. dest)
        end
      end
    end
  }
end

return M
