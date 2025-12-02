return {
  "nvim-autopairs",
  for_cat = 'general.always',
  event = "InsertEnter",
  after = function(plugin)
    require('nvim-autopairs').setup({
      check_ts = true,
    })
  end,
}
