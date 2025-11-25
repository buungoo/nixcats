local load_w_after = function(name)
  vim.cmd.packadd(name)
  vim.cmd.packadd(name .. '/after')
end

return {
  {
    "cmp-cmdline",
    for_cat = "general.blink",
    on_plugin = { "blink.cmp" },
    load = load_w_after,
  },
  {
    "blink.compat",
    for_cat = "general.blink",
    dep_of = { "cmp-cmdline" },
  },
  {
    "luasnip",
    for_cat = "general.blink",
    dep_of = { "blink.cmp" },
    after = function (_)
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      local ls = require('luasnip')

      vim.keymap.set({ "i", "s" }, "<M-n>", function()
          if ls.choice_active() then
              ls.change_choice(1)
          end
      end)
    end,
  },
  {
    "colorful-menu.nvim",
    for_cat = "general.blink",
    on_plugin = { "blink.cmp" },
  },
}
