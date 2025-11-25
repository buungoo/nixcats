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
      overrides = function(colors)
        local theme = colors.theme
        return {
          Search = { bg = colors.palette.roninYellow, fg = colors.palette.sumiInk0, bold = true },
          IncSearch = { bg = colors.palette.roninYellow, fg = colors.palette.sumiInk0, bold = true },
          CurSearch = { bg = colors.palette.roninYellow, fg = colors.palette.sumiInk0, bold = true },
        }
      end,
    }
    -- Set colorscheme if kanagawa is selected
    if nixCats('colorscheme') == 'kanagawa' or nixCats('colorscheme') == 'kanagawa-wave' then
      vim.cmd.colorscheme('kanagawa-wave')
    end
  end,
}
