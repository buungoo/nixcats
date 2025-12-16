return {
  load = function()
    local kanagawa_colors = require('kanagawa.colors').setup({ theme = 'wave' })
    if not kanagawa_colors then return end

    -- Get the original current line number color from Kanagawa
    local original_linenr = kanagawa_colors.palette.roninYellow  -- Kanagawa's default current line nr color

    require("line-number-change-mode").setup({
      mode = {
        n = {
          bg = kanagawa_colors.palette.sumiInk6,
          fg = original_linenr,  -- Use Kanagawa's original line number color
          bold = true,
        },
        i = {
          -- bg = kanagawa_colors.palette.springGreen,
          bg = kanagawa_colors.palette.dragonPink,
          fg = original_linenr,
          bold = true,
        },
        v = {
          bg = kanagawa_colors.palette.waveAqua2,
          fg = original_linenr,
          bold = true,
        },
        V = {
          bg = kanagawa_colors.palette.waveAqua1,
          fg = original_linenr,
          bold = true,
        },
        R = {
          bg = kanagawa_colors.palette.autumnRed,
          fg = original_linenr,
          bold = true,
        },
      }
    })
  end
}
