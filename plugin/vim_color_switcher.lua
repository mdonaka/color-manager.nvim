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
