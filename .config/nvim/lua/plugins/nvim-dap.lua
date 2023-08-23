local dap = require 'dap'
dap.adapters.perl = {
  type = 'executable',
  command = 'node',
  args = { '/home/seth/src/vscode-perl-debug/out/debugAdapter.js' },
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
