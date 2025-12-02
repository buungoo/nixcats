return {
  "fff.nvim",
  for_cat = 'general.always',
  event = "DeferredUIEnter",
  keys = {
    { "ff", function() require('fff').find_files() end, desc = 'FFF Find files' },
    { "<leader>sg", function() require('fff').grep_picker() end, mode = {"n"}, desc = '[S]earch by [G]rep', },
    { "<leader>sf", function() require('fff').find_files() end, mode = {"n"}, desc = '[S]earch [F]iles', },
    { "<leader>sp", function() require('fff').find_in_git_root() end, mode = {"n"}, desc = '[S]earch git [P]roject root', },
  },
  after = function(plugin)
    require('fff').setup({
      debug = {
        enabled = true,
        show_scores = true,
      },
      fuzzy = {
        max_typos = 4, -- Allow up to 4 typos for better fuzzy matching
      },
    })
  end,
}
