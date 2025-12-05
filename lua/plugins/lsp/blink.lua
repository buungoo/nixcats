return {
  "blink.cmp",
  for_cat = "general.blink",
  event = "InsertEnter",
  load = function(name)
    vim.cmd.packadd(name)
  end,
  after = function(plugin)
    require("blink.cmp").setup({
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-c>"] = { "cancel", "fallback" },
        ["<C-k>"] = { "snippet_forward", "fallback" },
        ["<C-j>"] = { "snippet_backward", "show_signature", "fallback" },
        ["<C-x><C-a>"] = (nixCats("ai") or nixCats("ai-mlx")) and require('minuet').make_blink_map() or nil,
      },

      appearance = {
        nerd_font_variant = "mono",
        kind_icons = {
          Minuet = "󰧑", -- AI/robot icon for minuet completions
        },
      },

      completion = {
        keyword = { range = "full" },
        trigger = {
          prefetch_on_insert = false, -- Recommended for minuet
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
        },

        list = {
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
            auto_insert = true,
          },
        },

        ghost_text = {
          enabled = true,
        },

        menu = {
          winhighlight = "FloatBorder:BlinkCmpSignatureHelpBorder",
          scrollbar = false,
          border = "rounded",
          direction_priority = { "n", "s" }, -- Prefer showing above (north) before below (south)
          auto_show = function(ctx) return ctx.mode ~= "cmdline" end, -- Always show in insert mode
          draw = {
            treesitter = { "lsp" },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 50,
          window = {
            border = "rounded",
          },
        },
      },

      signature = {
        enabled = true,
        trigger = {
          show_on_insert_on_trigger_character = true,
        },
        window = {
          border = "rounded",
        },
      },

      sources = {
        default = (nixCats("ai") or nixCats("ai-mlx")) and { "minuet", "lsp", "path", "snippets", "buffer" }
          or { "lsp", "path", "snippets", "buffer" },

        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },

        providers = {
          lsp = {
            async = true,
          },

          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },

          minuet = (nixCats("ai") or nixCats("ai-mlx")) and {
            name = "minuet",
            module = "minuet.blink",
            async = true,
            timeout_ms = 200,
            score_offset = 100, -- High priority to appear at top
          } or nil,
        },
      },
    })
  end,
}
