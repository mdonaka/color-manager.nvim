local M = {}

local api = vim.api
local preview = require('module.preview')
local opsions = require("module.config").options

-- awesome-vim-colorschemesからcolorscheme一覧とパスを取得
local function get_awesome_schemes()
  local root = vim.fn.stdpath("data") .. "/lazy/awesome-vim-colorschemes/colors/"
  local files = vim.fn.glob(root .. "*.vim", 0, 1)
  local names = {}
  local paths = {}
  for _, f in ipairs(files) do
    local fname = vim.fn.fnamemodify(f, ":t:r")
    table.insert(names, fname)
    paths[fname] = f
  end
  return names, paths
end


function M.pick_and_install_with_preview()
  local preview = require("module.preview")
  preview.colorscheme_action_with_preview {
    prompt = "Awesome Colorscheme> ",
    get_schemes_fn = get_awesome_schemes,
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
