local wezterm = require 'wezterm'
return {
  font_size = 18.0,
  font = wezterm.font 'DejaVuSansMono Nerd Font',
  color_scheme = 'kanagawabones',
  default_prog = { '/bin/bash' },
  hide_tab_bar_if_only_one_tab = true,
  audible_bell = 'Disabled',
}
