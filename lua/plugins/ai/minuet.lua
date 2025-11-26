-- Start llama.cpp server in background if not already running
local model_path = nixCats.extra("qwenModelPath")
if model_path then
  local model_filename = vim.fn.fnamemodify(model_path, ":t")

  -- Check if server is already running
  local handle = io.popen("pgrep -f 'llama-server.*" .. model_filename .. "'")
  local result = handle:read("*a")
  handle:close()

  if result == "" then
    -- Server not running, start it
    vim.notify("Starting llama.cpp server...", vim.log.levels.INFO)
    local cmd = string.format(
      "llama-server -m %s --port 8080 -c 4096 -ngl 99 --threads 4 > /tmp/llama-server.log 2>&1 &",
      model_path
    )
    os.execute(cmd)
    -- Give it a moment to start
    vim.defer_fn(function()
      vim.notify("llama.cpp server started", vim.log.levels.INFO)
    end, 2000)

    -- Stop server when Neovim exits
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        local kill_handle = io.popen("pkill -f 'llama-server.*" .. model_filename .. "'")
        kill_handle:close()
        vim.notify("Stopping llama.cpp server...", vim.log.levels.INFO)
      end,
    })
  end
end

-- Setup minuet
require("minuet").setup({
  provider = "openai_fim_compatible",
  n_completions = 3, -- Generate multiple suggestions
  context_window = 2048, -- Larger context for better completions
  provider_options = {
    openai_fim_compatible = {
      model = "qwen2.5-coder-7b-instruct",
      end_point = "http://localhost:8080/v1/completions",
      name = "llama.cpp",
      api_key = "TERM", -- Name of env var (TERM exists on all systems)
      stream = true,
      optional = {
        stop = nil,
        max_tokens = nil,
      },
      -- Llama.cpp FIM template for Qwen models
      template = {
        prompt = function(context_before_cursor, context_after_cursor, _)
          return '<|fim_prefix|>'
            .. context_before_cursor
            .. '<|fim_suffix|>'
            .. context_after_cursor
            .. '<|fim_middle|>'
        end,
        suffix = false,
      },
    },
  },
  throttle = 200, -- Faster trigger (200ms instead of 1000ms)
})

