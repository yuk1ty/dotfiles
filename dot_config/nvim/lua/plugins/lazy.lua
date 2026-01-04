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
  -- Claude Code
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>z", nil, desc = "AI/Claude Code" },
      { "<leader>zc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>zf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>zr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>zC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>zm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>zb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>zs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>zs",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      -- Diff management
      { "<leader>za", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>zd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  -- Pretty Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
  },
  -- Neoconf
  { "folke/neoconf.nvim" },
  -- Marp
  { "nwiizo/marp.nvim" },
  -- GitLink
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },
  -- Obsidian
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = { "markdown" },
    ---@module 'obsidian'
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/helloyuki-hub",
        },
      },
    },
    lazy = false,
  },
  -- sidekick
  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>xa",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>xs",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>xd",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>xt",
        function() require("sidekick.cli").send { msg = "{this}" } end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>xf",
        function() require("sidekick.cli").send { msg = "{file}" } end,
        desc = "Send File",
      },
      {
        "<leader>xv",
        function() require("sidekick.cli").send { msg = "{selection}" } end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>xp",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<leader>xc",
        function() require("sidekick.cli").toggle { name = "claude", focus = true } end,
        desc = "Sidekick Toggle Claude",
      },
    },
  },
}
