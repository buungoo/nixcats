-- kanagawa.nvim colorscheme configuration
return {
  "kanagawa.nvim",
  for_cat = 'general.extra',
  event = "VimEnter",
  priority = 1000,
  after = function(plugin)
    require('kanagawa').setup {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
    }
    -- Set colorscheme if kanagawa is selected
    if nixCats('colorscheme') == 'kanagawa' or nixCats('colorscheme') == 'kanagawa-wave' then
      vim.cmd.colorscheme('kanagawa-wave')
    end
  end,
}
