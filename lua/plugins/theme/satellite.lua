return {
  "satellite.nvim",
  for_cat = 'general.extra',
  event = "DeferredUIEnter",
  after = function(plugin)
    require("satellite").setup()
  end,
}
