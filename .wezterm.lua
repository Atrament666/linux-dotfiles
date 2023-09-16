local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'Apprentice'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font('Sauce Code Pro Nerd Font Mono')
config.font_size = 11

return config
