-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Force transparent background
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalSB", { bg = "NONE" })

-- Force transparent tabline/bufferline
vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = "NONE" })

-- Force float border and window separator colors (catppuccin mocha overlay0)
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#6c7086", bg = "NONE" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#6c7086", bg = "NONE" })
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#6c7086", bg = "NONE" })

-- Force NeoTree git colors to catppuccin mocha palette
vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = "#eba0ac", bold = true, italic = true }) -- maroon
vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#fab387", italic = true })             -- peach
vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = "#fab387", bold = true, italic = true }) -- peach

