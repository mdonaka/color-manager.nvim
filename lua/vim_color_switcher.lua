local M = {}

M.options = require("module.config").options
local random = require("module.random")

function M.setup(opts)
  opts = opts or {}
  for k, v in pairs(opts) do
    M.options[k] = v
  end
  random.pick_random()
  vim.opt.rtp:append(vim.fn.fnamemodify(M.options.colors_dir, ":h"))
end

return M
