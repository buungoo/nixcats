return {
  "krust-nvim",
  for_cat = 'rust',
  ft = "rust",
  keys = {
    { "<C-w>d", mode = { "n" }, function() require("krust").render() end, desc = "Show Rust diagnostics with krust" },
  },
  after = function(plugin)
    require('krust').setup({})
  end,
}
