-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  { import = "astrocommunity.colorscheme.catppuccin" },
  {
    "catppuccin",
    opts = {
      transparent_background = true,
    },
  },

  { import = "astrocommunity.pack.biome" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.gleam" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.scala" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.programming-language-support.rest-nvim" },

  { import = "astrocommunity.recipes.telescope-lsp-mappings" },
}
