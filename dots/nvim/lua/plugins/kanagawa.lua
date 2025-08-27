if true then return {} end


return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'kanagawa'
  end,
}
