-- :ColorSwitcherコマンドを追加
vim.api.nvim_create_user_command("ColorManager",
  function() require("module.choose_schema").choose_colorscheme_with_preview() end,
  {
    desc = "Select colorscheme",
  })

-- :ColorSwitcherInstallコマンドを追加
vim.api.nvim_create_user_command("ColorManagerInstall", function()
  require("module.choose_schema").pick_and_install_with_preview()
end, {
  desc = "Install colorscheme ",
})

-- :ColorSwitcherUninstallコマンドを追加
vim.api.nvim_create_user_command("ColorManagerUninstall", function()
  require("module.choose_schema").uninstall_colorscheme_with_preview()
end, {
  desc = "Uninstall colorscheme",
})
