-- nvim-window-picker: Quick window navigation using letter hints
return {
  "nvim-window-picker",
  for_cat = 'general.extra',
  keys = {
    {
      "<leader>w",
      function()
        require('nvim-window').pick()
      end,
      mode = "n",
      desc = "Jump to window"
    },
  },
  after = function(plugin)
    require('nvim-window').setup {
      -- The characters available for hinting windows (home row keys)
      chars = {
        'a', 's', 'd', 'f', 'j', 'k', 'l', 'h', 'g'
      },
      normal_hl = 'Normal',
      hint_hl = 'Bold',
      border = 'single',
      render = 'float',
    }
  end,
}
