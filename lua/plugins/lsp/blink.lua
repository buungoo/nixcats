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
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        keyword = { range = "full" },

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
          hl_group = "Comment",
        },

        menu = {
          winhighlight = "FloatBorder:BlinkCmpSignatureHelpBorder",
          scrollbar = false,
          border = "rounded",
          auto_show = true,
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
        window = {
          border = "rounded",
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },

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
        },
      },
    })
  end,
}
