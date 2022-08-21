local wezterm = require 'wezterm'

return {
  font_size = 18.0,
  font = wezterm.font 'DejaVuSansMono Nerd Font',
  color_scheme = 'kanagawabones',
  default_prog = { '/bin/bash' },
  hide_tab_bar_if_only_one_tab = true,
  audible_bell = 'Disabled',
  tab_max_width = 40,
  unix_domains = {
    {
      name = 'unix',
      no_serve_automatically = false,
    },
  },
  default_gui_startup_args = { 'connect', 'unix' },
  keys = {
    -- window
    { key = 'q', mods = 'CTRL|ALT', action = wezterm.action.QuitApplication },
    { key = 'm', mods = 'CTRL|ALT', action = wezterm.action.Hide },
    { key = 'f', mods = 'CTRL|ALT', action = wezterm.action.ToggleFullScreen },
    -- tab
    { key = 't', mods = 'CTRL|ALT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'CTRL|ALT', action = wezterm.action.CloseCurrentTab { confirm = false } },
    { key = '1', mods = 'ALT', action = wezterm.action.ActivateTab(0) },
    { key = '2', mods = 'ALT', action = wezterm.action.ActivateTab(1) },
    { key = '3', mods = 'ALT', action = wezterm.action.ActivateTab(2) },
    { key = '4', mods = 'ALT', action = wezterm.action.ActivateTab(3) },
    { key = '5', mods = 'ALT', action = wezterm.action.ActivateTab(4) },
    { key = '6', mods = 'ALT', action = wezterm.action.ActivateTab(5) },
    { key = '7', mods = 'ALT', action = wezterm.action.ActivateTab(6) },
    { key = '8', mods = 'ALT', action = wezterm.action.ActivateTab(7) },
    { key = '9', mods = 'ALT', action = wezterm.action.ActivateTab(8) },
    { key = '0', mods = 'ALT', action = wezterm.action.ActivateTab(9) },
    -- pane
    { key = 'w', mods = 'ALT', action = wezterm.action.CloseCurrentPane { confirm = false } },
    { key = 'h', mods = 'ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'v', mods = 'ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = 's', mods = 'ALT', action = wezterm.action.PaneSelect },
    { key = 'f', mods = 'ALT', action = wezterm.action.TogglePaneZoomState },
  },
}
