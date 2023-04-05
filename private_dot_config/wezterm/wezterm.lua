local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = 'GruvboxDark'

config.font = wezterm.font {
  family = 'Iosevka Term',
  harfbuzz_features = { 'dlig' },
}

config.font_size = 13.0
config.bold_brightens_ansi_colors = 'BrightAndBold'
config.cursor_thickness = 1.0
-- fonts look better on WebGpu than OpenGL (on mac's at least)
config.front_end = 'WebGpu'
-- use HighPerformance to help reduce input lag
config.webgpu_power_preference = 'HighPerformance'

return config

