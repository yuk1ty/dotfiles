-- IntelliJ LSP for Java and Kotlin

---@type LazySpec
return {
  "JetBrains/intellij-lsp.nvim",
  dependencies = { "mfussenegger/nvim-dap" },
  opts = {
    accept_eula = true,
    filetypes = { "java", "kotlin" },
  },
  config = function(_, opts)
    require("intellij-lsp").setup(opts)
    local group = vim.api.nvim_create_augroup("intellij_lsp_kotlin_keymaps", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client or client.name ~= "intellij" then return end
        local buf = args.buf
        if vim.bo[buf].filetype ~= "kotlin" then return end
        local map = function(lhs, fn, desc) vim.keymap.set("n", lhs, fn, { buffer = buf, desc = desc }) end
        local supports = function(method) return not client.supports_method or client:supports_method(method) end
        map(
          "<leader>ko",
          function() vim.lsp.buf.code_action { apply = true, context = { only = { "source.organizeImports" } } } end,
          "Organize imports"
        )
        if supports "textDocument/formatting" then map("<leader>kf", "<cmd>IntellijLspFormat<cr>", "Format buffer") end
        if supports "textDocument/documentSymbol" then
          map("<leader>ks", vim.lsp.buf.document_symbol, "Document symbols")
        end
        if supports "textDocument/codeAction" then
          map("<leader>ka", vim.lsp.buf.code_action, "Code actions")
          map(
            "<leader>kq",
            function() vim.lsp.buf.code_action { apply = true, context = { only = { "quickfix" } } } end,
            "Quick fix"
          )
        end
        map("<leader>kh", function()
          if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = buf }, { bufnr = buf })
          end
        end, "Toggle inlay hints")
        if supports "textDocument/rename" then map("<leader>kn", vim.lsp.buf.rename, "Rename symbol") end
        if supports "textDocument/implementation" then
          map("<leader>ki", vim.lsp.buf.implementation, "Go to implementation")
        end
        if supports "textDocument/typeDefinition" then
          map("<leader>kt", vim.lsp.buf.type_definition, "Go to type definition")
        end
      end,
    })
  end,
}
