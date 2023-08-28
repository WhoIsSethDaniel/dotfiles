local dap = require 'dap'
dap.adapters.perl = {
  type = 'executable',
  command = '/home/seth/.local/share/nvim/mason/bin/perl-debug-adapter',
  args = {},
}
dap.configurations.perl = {
  {
    type = 'perl',
    request = 'launch',
    name = 'Launch Perl',
    program = '${workspaceFolder}/${relativeFile}',
  },
}

dap.set_log_level 'TRACE'
