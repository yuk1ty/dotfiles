---@type LazySpec
return {
  "Julian/lean.nvim",
  event = { "BufReadPre *.lean", "BufNewFile *.lean" },
  ---@type lean.Config
  opts = {
    mappings = true,
  },
}
