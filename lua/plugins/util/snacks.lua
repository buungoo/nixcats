-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  if current_file == "" then
    current_dir = cwd
  else
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom grep function to search in git root
local function grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('snacks').picker.grep({ cwd = git_root })
  end
end

return {
  "snacks.nvim",
  for_cat = 'general.always',
  event = "DeferredUIEnter",
  keys = {
    { "<leader>sp", grep_git_root, mode = {"n"}, desc = '[S]earch git [P]roject root', },
    { "<leader>sc", function() require('snacks').picker.lines() end, mode = {"n"}, desc = '[S]earch in [C]urrent buffer', },
    { "<leader>sx", function() require('snacks').picker.grep_buffers() end, mode = {"n"}, desc = '[S]earch in open buffers' },
    { "<leader>sb", function() require('snacks').picker.buffers() end, mode = {"n"}, desc = '[ ] Find existing buffers', },
    { "<leader>s.", function() require('snacks').picker.recent() end, mode = {"n"}, desc = '[S]earch Recent Files ("." for repeat)', },
    { "<leader>sr", function() require('snacks').picker.resume() end, mode = {"n"}, desc = '[S]earch [R]esume', },
    { "<leader>sd", function() require('snacks').picker.diagnostics() end, mode = {"n"}, desc = '[S]earch [D]iagnostics', },
    { "<leader>sg", function() require('snacks').picker.grep() end, mode = {"n"}, desc = '[S]earch by [G]rep', },
    { "<leader>sw", function() require('snacks').picker.grep_word() end, mode = {"n"}, desc = '[S]earch current [W]ord', },
    { "<leader>ss", function() require('snacks').picker.pickers() end, mode = {"n"}, desc = '[S]earch [S]elect Picker', },
    { "<leader>sf", function() require('snacks').picker.files() end, mode = {"n"}, desc = '[S]earch [F]iles', },
    { "<leader>sk", function() require('snacks').picker.keymaps() end, mode = {"n"}, desc = '[S]earch [K]eymaps', },
    { "<leader>sh", function() require('snacks').picker.help() end, mode = {"n"}, desc = '[S]earch [H]elp', },
  },
  after = function(plugin)
    require('snacks').setup({
      picker = {
        ui_select = true,
        matcher = {
          fuzzy = true,
          smartcase = true,
        },
        layout = {
          preset = "ivy_split",
          -- layout = "ivy_split",
        },
      },
    })
  end,
}
