local colorschemeName = nixCats('colorscheme')
if not require('nixCatsUtils').isNixCats then
  colorschemeName = 'onedark'
end
-- Could I lazy load on colorscheme with lze?
-- sure. But I was going to call vim.cmd.colorscheme() during startup anyway
-- this is just an example, feel free to do a better job!
vim.cmd.colorscheme(colorschemeName)

local ok, notify = pcall(require, "notify")
if ok then
  notify.setup({
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { focusable = false })
    end,
  })
  vim.notify = notify
  vim.keymap.set("n", "<Esc>", function()
      notify.dismiss({ silent = true, })
      vim.cmd("nohlsearch")
  end, { desc = "dismiss notify popup and clear hlsearch" })
end

-- Setup minuet-ai if enabled (it's a startup plugin, not lazy loaded via lze)
if nixCats('ai') then
  require("plugins.ai.minuet")
elseif nixCats('ai-mlx') then
  require("plugins.ai.minuet-mlx")
end

-- Setup line number change mode (needs to load after kanagawa)
require("plugins.theme.line-number-change-mode").load()

require('lze').load {
  { import = "plugins.lsp.conform", },
  { import = "plugins.lsp.nvim-lint", },
  { import = "plugins.lsp.lspconfig", },
  { import = "plugins.lsp.treesitter", },
  { import = "plugins.lsp.completion", },
  { import = "plugins.lsp.blink", },
  { import = "plugins.lsp.krust", },
  { import = "plugins.theme.kanagawa", },
  { import = "plugins.theme.hlchunk", },
  { import = "plugins.util.nvim-window", },
  { import = "plugins.util.flash", },
  { import = "plugins.util.snacks", },
  { import = "plugins.util.autopairs", },
  -- { import = "plugins.util.oil", },
  { import = "plugins.util.mini-files", },
  { import = "plugins.util.markdown-preview", },
  { import = "plugins.util.undotree", },
  { import = "plugins.util.comment", },
  { import = "plugins.util.nvim-surround", },
  { import = "plugins.util.startuptime", },
  { import = "plugins.util.fidget", },
  { import = "plugins.util.gitsigns", },
  { import = "plugins.theme.satellite", },
  { import = "plugins.util.nvim-highlight-colors", },
  { import = "plugins.util.which-key", },
  -- { import = "plugins.util.fff", },
}
