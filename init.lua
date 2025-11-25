--[[
NOTE:
if you plan to always load your nixCats via nix,
you can safely ignore this setup call,
and the require('myLuaConf.non_nix_download') call below it.
as well as the entire lua/myLuaConf/non_nix_download file.
Unless you want the lzUtils file, or the lazy wrapper, you also wont need lua/nixCatsUtils

IF YOU DO NOT DO THIS SETUP CALL:
the result will be that, when you load this folder without using nix,
the global nixCats function which you use everywhere
to check for categories will throw an error.
This setup function will give it a default value.
Of course, if you only ever download nvim with nix, this isnt needed.]]
--[[ ----------------------------------- ]]
--[[ This setup function will provide    ]]
--[[ a default value for the nixCats('') ]]
--[[ function so that it will not throw  ]]
--[[ an error if not loaded via nixCats  ]]
--[[ ----------------------------------- ]]
require('nixCatsUtils').setup {
  non_nix_value = true,
}
--[[
Nix puts the plugins
into the directories paq-nvim expects them to be in,
because both follow the normal neovim scheme.
So you just put the URLs and build steps in there, and use its opt option to do the same
thing as putting a plugin in nixCat's optionalPlugins field.
then load the plugins via paq-nvim
YOU are in charge of putting the plugin
urls and build steps in there, which will only be used when not on nix,
and you should keep any setup functions
OUT of that file, as they are ONLY loaded when this
configuration is NOT loaded via nix.
--]]
-- require("non_nix_download")
-- OK, again, that isnt needed if you load this setup via nix, but it is an option.
-- Uncomment the line above if you need to load this config without nix.

--[[
outside of when you want to use the nixCats global command
to decide if something should be loaded, or to pass info from nix to lua,
thats pretty much everything specific to nixCats that
needs to be in your config.
If you always want to load it via nix,
you pretty much dont need this file at all, and you also won't need
anything within lua/nixCatsUtils, nor will that be in the default template.
that directory is addable via the luaUtils template.
it is not required, but has some useful utility functions.
--]]

-- NOTE: various, non-plugin config
require('config.opts_and_keys')

-- NOTE: register an extra lze handler with the spec_field 'for_cat'
-- that makes enabling an lze spec for a category slightly nicer
require("lze").register_handlers(require('nixCatsUtils.lzUtils').for_cat)

-- NOTE: Register another one from lzextras. This one makes it so that
-- you can set up lsps within lze specs,
-- and trigger lspconfig setup hooks only on the correct filetypes
require('lze').register_handlers(require('lzextras').lsp)
-- demonstrated in ./LSPs/init.lua

-- NOTE: general plugins
require("plugins")

-- NOTE: obviously, more plugins, but more organized by what they do below

require("config.LSPs")

-- NOTE: we even ask nixCats if we included our debug stuff in this setup! (we didnt)
-- But we have a good base setup here as an example anyway!
if nixCats('debug') then
  require('config.debug')
end
-- NOTE: we included these though! Or, at least, the category is enabled.
-- these contain nvim-lint and conform setups.
if nixCats('lint') then
  require('config.lint')
end
if nixCats('format') then
  require('config.format')
end
-- NOTE: I didnt actually include any linters or formatters in this configuration,
-- but it is enough to serve as an example.
