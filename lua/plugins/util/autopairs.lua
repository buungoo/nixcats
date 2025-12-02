return {
  "nvim-autopairs",
  for_cat = 'general.always',
  event = "InsertEnter",
  after = function(plugin)
    require('nvim-autopairs').setup({
      check_ts = true,
    })
    -- Integrate with blink.cmp
    local ok, cmp = pcall(require, 'blink.cmp')
    if ok then
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  end,
}
