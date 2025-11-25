-- hlchunk.nvim configuration for visual chunk/indent guides
return {
  "hlchunk.nvim",
  for_cat = 'general.extra',
  event = "UIEnter",
  after = function(plugin)
    local kanagawa_colors = require('kanagawa.colors').setup({ theme = 'wave' })
    if not kanagawa_colors then
      return
    end

    require('hlchunk').setup({
      chunk = {
        enable = true,
        use_treesitter = true,
        chars = {
          right_arrow = '─',
        },
        delay = 0,
        duration = 100,
        style = {
          kanagawa_colors.palette.roninYellow, -- Primary chunk color
          kanagawa_colors.palette.autumnRed, -- Error-containing chunks
        },
      },
      indent = {
        enable = true,
        chars = {
          '│',
        },
        style = {
          kanagawa_colors.palette.sumiInk5, -- Subtle indent guide color
        },
      },
    })
  end,
}
