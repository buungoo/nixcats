return {
  "vscode-diff.nvim",
  for_cat = 'general.extra',
  event = "DeferredUIEnter",
  cmd = { "CodeDiff" },
  keys = {
    { "<leader>gd", '<cmd>CodeDiff<CR>', desc = "[G]it [D]iff" },
  },
  -- keys = {
  --   { "<leader>g", mode = { "n" }, function() require("krust").render() end, desc = "Show Rust diagnostics with krust" },
  -- },
  -- after = function(plugin)
  --   require('krust').setup({})
  -- end,
}
