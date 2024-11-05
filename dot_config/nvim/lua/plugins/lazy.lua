---@type LazySpec
return {
  -- use haskell tools
  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    version = "4.2.0",
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    init = function() vim.g.haskell_tools = {} end,
    lazy = false,
  },
  -- Enable Zen Mode
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.9,
      },
      plugins = {
        tmux = { enabled = true },
        todo = { enabled = true },
        wezterm = { enabled = true, font = "+2" },
      },
    },
  },
  -- Enable GitHub Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      debug = true,
      window = {
        layout = "float",
        relative = "cursor",
        width = 1,
        height = 0.4,
        row = 1,
      },
    },
    keys = {
      { "<leader>.", "<cmd>CopilotChat<cr>", desc = "Open Copilot Chat" },
    },
  },
}
