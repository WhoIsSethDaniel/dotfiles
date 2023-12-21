-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
return {
  cmd = { 'gopls', '--remote=auto' },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  settings = {
    gopls = {
      buildFlags = nil,
      env = nil,
      directoryFilters = nil,
      ['local'] = '',
      memoryMode = 'Normal',
      gofumpt = true,
      usePlaceholders = true,
      semanticTokens = true,
      staticcheck = true,
      hoverKind = 'Structured',
      annotations = {
        bounds = true,
        escape = true,
        inline = true,
        ['nil'] = true,
      },
      -- may also be "godoc.org"
      linkTarget = 'pkg.go.dev',
      linksInHover = true,
      importShortcut = 'Both',
      experimentalPostfixCompletions = true,
      diagnosticsDelay = '500ms',
      vulncheck = 'Imports',
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = false,
        parameterNames = false,
        rangeVariableTypes = true,
      },
      analyses = {
        asmdecl = true,
        assign = true,
        atomic = true,
        atomicalign = true,
        bools = true,
        buildtag = true,
        cgocall = true,
        composites = true,
        copylocks = true,
        deepequalerrors = true,
        errorsas = true,
        fieldalignment = true,
        fillreturns = true,
        fillstruct = true,
        httpresponse = true,
        ifaceassert = true,
        loopclosure = true,
        lostcancel = true,
        nilfunc = true,
        nilness = true,
        nonewvars = true,
        noresultvalues = true,
        printf = true,
        shadow = true,
        shift = true,
        simplifyrange = true,
        simplifyslice = true,
        sortslice = true,
        stdmethods = true,
        stringintconv = true,
        structtag = true,
        testinggoroutine = true,
        tests = true,
        undeclaredname = true,
        unmarshal = true,
        unreachable = true,
        unsafeptr = true,
        unusedparams = true,
        unusedresult = true,
        unusedwrite = true,
      },
      codelenses = {
        gc_details = true,
        generate = true,
        regenerate_cgo = false,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
    },
  },
}
