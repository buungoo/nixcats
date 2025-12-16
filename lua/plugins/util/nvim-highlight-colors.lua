return {
  "nvim-highlight-colors",
  for_cat = 'general.extra',
  event = "DeferredUIEnter",
  after = function(plugin)
    require('nvim-highlight-colors').setup({
      render = "virtual",
      virtual_symbol = "●",
      virtual_symbol_position = "eol",
    })
  end,
}
