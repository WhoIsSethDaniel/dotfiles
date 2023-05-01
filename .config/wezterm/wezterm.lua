-- https://wezfurlong.org/wezterm/config/lua/config/index.html
-- https://wezfurlong.org/wezterm/config/lua/keyassignment/index.html
local wezterm = require 'wezterm'

return {
  term = 'wezterm',
  check_for_updates = false,
  warn_about_missing_glyphs = false,
  font_size = 18.0,
  font = wezterm.font_with_fallback {
    'DejaVuSansMono Nerd Font',
    'CaskadydiaCove Nerd Font Mono',
    'Hack Nerd Font Mono',
  },
  -- color_scheme = 'kanagawabones',  -- for some reason really slows things down; particularly neovim
  default_prog = { '/bin/bash' },
  hide_tab_bar_if_only_one_tab = true,
  audible_bell = 'Disabled',
  tab_max_width = 40,
  scrollback_lines = 10000,
  unix_domains = {
    {
      name = 'unix',
      no_serve_automatically = false,
    },
  },
  default_gui_startup_args = { 'connect', 'unix' },
  force_reverse_video_cursor = true,
  colors = {
    foreground = '#dcd7ba',
    background = '#000000',

    cursor_bg = '#c8c093',
    cursor_fg = '#c8c093',
    cursor_border = '#c8c093',

    selection_fg = '#c8c093',
    selection_bg = '#2d4f67',

    scrollbar_thumb = '#16161d',
    split = '#36363d',

    ansi = { '#090618', '#c34043', '#76946a', '#c0a36e', '#7e9cd8', '#957fb8', '#6a9589', '#c8c093' },
    brights = { '#727169', '#e82424', '#98bb6c', '#e6c384', '#7fb4ca', '#938aa9', '#7aa89f', '#dcd7ba' },
    indexed = { [16] = '#ffa066', [17] = '#ff5d62' },
  },
  keys = {
    -- window
    { key = 'q', mods = 'CTRL|ALT', action = wezterm.action.QuitApplication },
    { key = 'm', mods = 'CTRL|ALT', action = wezterm.action.Hide },
    { key = 'f', mods = 'CTRL|ALT', action = wezterm.action.ToggleFullScreen },
    -- tab
    { key = 't', mods = 'CTRL|ALT', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'CTRL|ALT', action = wezterm.action.CloseCurrentTab { confirm = false } },
    { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.DisableDefaultAssignment },
    { key = 'j', mods = 'CTRL|ALT', action = wezterm.action.ActivateTabRelative(-1) },
    { key = 'k', mods = 'CTRL|ALT', action = wezterm.action.ActivateTabRelative(1) },
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
