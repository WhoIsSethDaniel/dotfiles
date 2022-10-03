-- matchup
-- suppressing matchit loading is not required
vim.g.matchup_enabled = 1
vim.g.matchup_mappings_enabled = 1
-- 0: no highlighting of matches
-- 1: highlighting of matches
vim.g.matchup_matchparen_enabled = 1
vim.g.matchup_mouse_enabled = 0
vim.g.matchup_motion_enabled = 1
vim.g.matchup_text_obj_enabled = 1
-- 0 : show matches in strings/comments
-- 1 : some matches in strings/comments
-- 2 : no matches in strings/comments
vim.g.matchup_delim_noskips = 0
vim.g.matchup_matchparen_offscreen = { ['method'] = 'popup' }
