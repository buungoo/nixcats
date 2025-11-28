-- Start MLX server in background if not already running
local model_path = nixCats.extra("qwenModelMLX")
if model_path then
  -- Check if server is already running
  local handle = io.popen("pgrep -f 'mlx_lm.server'")
  local result = handle:read("*a")
  handle:close()

  if result == "" then
    -- Server not running, start it
    vim.notify("Starting MLX server with model from Nix store...", vim.log.levels.INFO)
    -- Create a wrapper script that sets PATH for clang++
    local wrapper_script = "/tmp/start-mlx-server.sh"
    local wrapper_content = string.format([[
#!/bin/sh
export PATH=%s
exec mlx_lm.server --model %s --port 8080
]], vim.env.PATH, model_path)

    local f = io.open(wrapper_script, "w")
    if f then
      f:write(wrapper_content)
      f:close()
      os.execute("chmod +x " .. wrapper_script)
    end

    local cmd = string.format("%s > /tmp/mlx-server.log 2>&1 &", wrapper_script)
    os.execute(cmd)
    -- Give it a moment to load the model
    vim.defer_fn(function()
      vim.notify("MLX server started. Check /tmp/mlx-server.log for details.", vim.log.levels.INFO)
    end, 3000)

    -- Stop server when Neovim exits
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        local kill_handle = io.popen("pkill -f 'mlx_lm.server'")
        kill_handle:close()
        vim.notify("Stopping MLX server...", vim.log.levels.INFO)
      end,
    })
  else
    vim.notify("MLX server already running", vim.log.levels.INFO)
  end
end

-- Setup minuet with MLX server
require("minuet").setup({
  provider = "openai_fim_compatible",
  n_completions = 1,
  context_window = 2048,
  provider_options = {
    openai_fim_compatible = {
      model = "mlx-community/Qwen2.5-Coder-7B-Instruct-4bit",
      end_point = "http://localhost:8080/v1/completions",  -- MLX server OpenAI-compatible API
      name = "MLX",
      api_key = "TERM",
      stream = true,
      optional = {
        stop = nil,
        max_tokens = 512,
      },
      -- FIM template for Qwen models
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
  throttle = 200,
})
