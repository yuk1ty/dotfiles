local wezterm = require 'wezterm';

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Catppuccin Mocha'

config.colors = {
  indexed = { [16] = '#1e1e1e' },
}

config.window_background_opacity = 0.9

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 13.0

return config
