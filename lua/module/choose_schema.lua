local M = {}

--- カラースキームをプレビュー付きで選択・適用する
-- @function M.choose_colorscheme_with_preview
-- @usage
--   require('yourmodule').choose_colorscheme_with_preview()
-- @desc
--   options.colors_dir にあるカラースキームから選択＆リアルタイムプレビュー。
--   keep_last=true なので選択したスキームがそのまま適用される。
function M.choose_colorscheme_with_preview()
  preview.colorscheme_action_with_preview {
    prompt = "Choose Colorscheme> ",
    dir = options.colors_dir,
    keep_last = true,
    on_select_fn = function(scheme, _)
      if scheme then
        pcall(vim.cmd, "colorscheme " .. scheme)
      end
    end
  }
end

--- awesome-vim-colorschemes からカラースキームをプレビュー付きで選択＆インストール
-- @function M.pick_and_install_with_preview
-- @usage
--   require('yourmodule').pick_and_install_with_preview()
-- @desc
--   stdpath("data")/lazy/awesome-vim-colorschemes/colors/ から選択し、
--   options.colors_dir にコピー。コピー失敗時はメッセージ表示。
function M.pick_and_install_with_preview()
  preview.colorscheme_action_with_preview {
    prompt = "Awesome Colorscheme> ",
    dir = vim.fn.stdpath("data") .. "/lazy/awesome-vim-colorschemes/colors/",
    on_select_fn = function(scheme, scheme_paths)
      local src = scheme_paths[scheme]
      if src then
        local dest = options.colors_dir .. vim.fn.fnamemodify(src, ":t")
        local cp_result = vim.fn.system({ 'cp', src, dest })
        if vim.v.shell_error ~= 0 then
          print("ファイルコピー失敗: " .. dest .. " : " .. vim.inspect(cp_result))
        end
      end
    end
  }
end

--- カラースキームをプレビュー付きで選択・アンインストール
-- @function M.uninstall_colorscheme_with_preview
-- @usage
--   require('yourmodule').uninstall_colorscheme_with_preview()
-- @desc
--   options.colors_dir にあるカラースキームを選択し、ファイルを削除。
--   削除失敗時のみエラーメッセージを表示。
function M.uninstall_colorscheme_with_preview()
  preview.colorscheme_action_with_preview {
    prompt = "Uninstall Colorscheme> ",
    dir = options.colors_dir,
    on_select_fn = function(scheme, scheme_paths)
      local target = scheme_paths[scheme]
      if target and vim.fn.filereadable(target) == 1 then
        local ok, err = pcall(vim.fn.delete, target)
        if not ok or err ~= 0 then
          print("アンインストール失敗: " .. target)
        end
      end
    end
  }
end

return M
