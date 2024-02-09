local wezterm = require 'wezterm';

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Catppuccin Mocha'
-- To reset the colour scheme since Catppuccin Mocha sets too bright orange to indexed 16.
-- This makes me difficult to see operations, for instance, renaming in Neovim.
config.colors = {
  indexed = { [16] = '#1e1e1e' },
}

config.window_background_opacity = 0.6
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font_with_fallback({
  { family = 'JetBrainsMono Nerd Font' },
  { family = 'YuGothic' }
})
config.font_size = 12.0

return config
