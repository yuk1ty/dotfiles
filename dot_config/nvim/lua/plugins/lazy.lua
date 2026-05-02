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
  -- Kotlin
  {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    config = function()
      require("kotlin").setup {
        root_markers = {
          "gradlew",
          ".git",
          "mvnw",
          "settings.gradle",
        },
        jre_path = nil,
        jdk_for_symbol_resolution = nil,
        jvm_args = {
          "-Xmx8g",
        },
        inlay_hints = {
          enabled = true, -- Enable inlay hints (auto-enable on LSP attach)
          parameters = true, -- Show parameter names
          parameters_compiled = true, -- Show compiled parameter names
          parameters_excluded = false, -- Show excluded parameter names
          types_property = true, -- Show property types
          types_variable = true, -- Show local variable types
          function_return = true, -- Show function return types
          function_parameter = true, -- Show function parameter types
          lambda_return = true, -- Show lambda return types
          lambda_receivers_parameters = true, -- Show lambda receivers/parameters
          value_ranges = true, -- Show value ranges
          kotlin_time = true, -- Show kotlin.time warnings
        },
      }

      -- kotlin.nvim bypasses AstroLSP by calling vim.lsp.config/vim.lsp.enable directly,
      -- so picker-lsp-mappings (grr, gd, etc.) are not applied. Re-apply them here.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kotlin_lsp_picker_mappings", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or client.name ~= "kotlin_ls" then return end
          local buf = args.buf
          local map = function(lhs, fn, desc) vim.keymap.set("n", lhs, fn, { buffer = buf, desc = desc }) end
          if client:supports_method "textDocument/references" then
            map("grr", function() require("snacks.picker").lsp_references() end, "LSP References")
          end
          if client:supports_method "textDocument/implementation" then
            map("gri", function() require("snacks.picker").lsp_implementations() end, "LSP Implementations")
          end
          if client:supports_method "textDocument/definition" then
            map("gd", function() require("snacks.picker").lsp_definitions() end, "LSP Definitions")
          end
          if client:supports_method "textDocument/typeDefinition" then
            map("gy", function() require("snacks.picker").lsp_type_definitions() end, "LSP Type Definitions")
          end
          map("gO", function() require("snacks.picker").lsp_symbols() end, "LSP Document Symbols")
        end,
      })
    end,
    keys = {
      { "<leader>ko", "<cmd>KotlinOrganizeImports<cr>", desc = "Organize imports", ft = "kotlin" },
      { "<leader>kf", "<cmd>KotlinFormat<cr>", desc = "Format buffer", ft = "kotlin" },
      { "<leader>ks", "<cmd>KotlinSymbols<cr>", desc = "Document symbols", ft = "kotlin" },
      { "<leader>ka", "<cmd>KotlinCodeActions<cr>", desc = "Code actions", ft = "kotlin" },
      { "<leader>kq", "<cmd>KotlinQuickFix<cr>", desc = "Quick fix", ft = "kotlin" },
      { "<leader>kh", "<cmd>KotlinInlayHintsToggle<cr>", desc = "Toggle inlay hints", ft = "kotlin" },
      { "<leader>kn", "<cmd>KotlinRename<cr>", desc = "Rename symbol", ft = "kotlin" },
      { "<leader>ki", "<cmd>KotlinImplementation<cr>", desc = "Go to implementation", ft = "kotlin" },
      { "<leader>kt", "<cmd>KotlinTypeDefinition<cr>", desc = "Go to type definition", ft = "kotlin" },
    },
  },
}
