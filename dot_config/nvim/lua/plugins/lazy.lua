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
  -- Octo.nvim
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    cmd = { "Octo", "OctoReviewQueue" },
    opts = {
      picker = "snacks",
    },
    config = function(_, opts)
      require("octo").setup(opts)
      vim.api.nvim_create_user_command("OctoReviewQueue", function()
        vim.cmd([[Octo pr list search="is:open is:pr review-requested:@me"]])
      end, { desc = "List PRs where I'm requested as a reviewer" })
    end,
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
        -- {
        --   name = "personal",
        --   path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/helloyuki-hub",
        -- },
        {
          name = "helloyuki.obsidian (work)",
          path = "~/github/private/yuk1ty/helloyuki.obsidian",
        },
        {
          name = "helloyuki.obsidian (personal)",
          path = "~/github.com/yuk1ty/helloyuki.obsidian",
        },
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
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
          enabled = false,
        },
        tools = {
          claude = {
            cmd = { "lapdog", "claude" },
          },
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
