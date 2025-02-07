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
  -- Enable GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 100,
        keymap = {
          accept = "<C-g>l",
          accept_word = false,
          accept_line = false,
          next = "<C-g>j",
          prev = "<C-g>k",
          dismiss = "<C-g>d",
        },
      },
    },
    lazy = false,
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
  -- Obsidian
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opt = {
      workspaces = {
        {
          name = "helloyuki-hub",
          path = "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/helloyuki-hub",
        },
      },
      templates = {
        folder = "1-templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
    },
  },
}
