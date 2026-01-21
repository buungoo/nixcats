local catUtils = require('nixCatsUtils')

return {
  {
    -- Lua Language Server
    "lua_ls",
    enabled = nixCats('lua'),
    lsp = {
      filetypes = { 'lua' },
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          formatters = {
            ignoreComments = true,
          },
          signatureHelp = { enabled = true },
          diagnostics = {
            globals = { "nixCats", "vim", },
            disable = { 'missing-fields' },
          },
          telemetry = { enabled = false },
        },
      },
    },
  },
  {
    -- Go Language Server
    "gopls",
    for_cat = "go",
    lsp = {
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
    },
  },
  {
    -- Rust Language Server
    "rust_analyzer",
    for_cat = "rust",
    lsp = {
      filetypes = { "rust" },
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
          },
          check = {
            command = "clippy",
          },
        },
      },
    },
  },
  {
    -- C/C++ Language Server
    "clangd",
    for_cat = "c",
    lsp = {
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders=true",
      },
    },
  },
  {
    -- Java Language Server
    "jdtls",
    for_cat = "java",
    lsp = {
      filetypes = { "java" },
    },
  },
  {
    -- Nix Language Server (rnix) - for non-NixOS systems
    "rnix",
    enabled = not catUtils.isNixCats,
    lsp = {
      filetypes = { "nix" },
    },
  },
  {
    -- Nix Language Server (nil) - for non-NixOS systems
    "nil_ls",
    enabled = not catUtils.isNixCats,
    lsp = {
      filetypes = { "nix" },
    },
  },
  {
    -- Nix Language Server (nixd) - for NixOS systems
    "nixd",
    enabled = catUtils.isNixCats and nixCats('nix'),
    lsp = {
      filetypes = { "nix" },
      settings = {
        nixd = {
          -- nixd requires some configuration.
          -- luckily, the nixCats plugin is here to pass whatever we need!
          -- we passed this in via the `extra` table in our packageDefinitions
          -- for additional configuration options, refer to:
          -- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
          nixpkgs = {
            -- in the extras set of your package definition:
            -- nixdExtras.nixpkgs = ''import ${pkgs.path} {}''
            expr = nixCats.extra("nixdExtras.nixpkgs") or [[import <nixpkgs> {}]],
          },
          options = {
            -- If you integrated with your system flake,
            -- you should use inputs.self as the path to your system flake
            -- that way it will ALWAYS work, regardless
            -- of where your config actually was.
            nixos = {
              -- nixdExtras.nixos_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").nixosConfigurations.configname.options''
              expr = nixCats.extra("nixdExtras.nixos_options")
            },
            -- If you have your config as a separate flake, inputs.self would be referring to the wrong flake.
            -- You can override the correct one into your package definition on import in your main configuration,
            -- or just put an absolute path to where it usually is and accept the impurity.
            ["home-manager"] = {
              -- nixdExtras.home_manager_options = ''(builtins.getFlake "path:${builtins.toString inputs.self.outPath}").homeConfigurations.configname.options''
              expr = nixCats.extra("nixdExtras.home_manager_options")
            }
          },
          formatting = {
            command = { "nixfmt" }
          },
          diagnostic = {
            suppress = {
              "sema-escaping-with"
            }
          }
        }
      },
    },
  },
}
