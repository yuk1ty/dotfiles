local wezterm = require("wezterm")

-- Turn on Zen Mode as intended (https://github.com/folke/zen-mode.nvim?tab=readme-ov-file#-plugins)
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"
-- To reset the colour scheme since Catppuccin Mocha sets too bright orange to indexed 16.
-- This makes me difficult to see operations, for instance, renaming in Neovim.
config.colors = {
	indexed = { [16] = "#1e1e1e" },
}

config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font_with_fallback({
	{ family = "UDEV Gothic 35NFLG" },
})
config.font_size = 13.0

return config
