local mod = require("vim_color_switcher")

-- 起動時にランダムにカラースキーマを変更
if mod.options.randomize_colorscheme_on_startup then
  local util = require("module.util")
  local schemes = util.get_colorscheme_files()
  local pick = util.pick_random(schemes)
  vim.cmd.colorscheme(pick)
end

-- :ColorSwitcherコマンドを追加
vim.api.nvim_create_user_command("ColorSwitcher",
  function() require("module.choose").choose_colorscheme_with_preview() end,
  {
    desc = "Switch colorscheme",
  })

-- :ColorSwitcherInstallコマンドを追加
vim.api.nvim_create_user_command("ColorSwitcherInstall", function()
  require("module.install").pick_and_install_with_preview()
end, {
  desc = "Install colorscheme ",
})

-- :ColorSwitcherUninstallコマンドを追加
vim.api.nvim_create_user_command("ColorSwitcherUninstall", function()
  require("module.uninstall").uninstall_colorscheme_with_preview()
end, {
  desc = "Uninstall colorscheme",
})
