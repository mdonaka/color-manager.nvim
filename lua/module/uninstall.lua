local M = {}

local api = vim.api
local preview = require('module.preview')
local options = require('module.config').options

-- ローカルcolors/ディレクトリからカラースキーム一覧を取得
local function get_local_schemes()
  local files = vim.fn.glob(options.colors_dir .. "*.vim", 0, 1)
  local names = {}
  local paths = {}
  for _, f in ipairs(files) do
    local fname = vim.fn.fnamemodify(f, ":t:r")
    table.insert(names, fname)
    paths[fname] = f
  end
  return names, paths
end

function M.uninstall_colorscheme_with_preview()
  local preview = require("module.preview")
  preview.colorscheme_action_with_preview {
    prompt = "Uninstall Colorscheme> ",
    get_schemes_fn = get_local_schemes,
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
