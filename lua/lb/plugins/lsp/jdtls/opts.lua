local M = {}

M.extendedClientCapabilities = {
  progressReportProvider = true,
  classFileContentsSupport = true,
  generateToStringPromptSupport = true,
  hashCodeEqualsPromptSupport = true,
  advancedExtractRefactoringSupport = true,
  advancedOrganizeImportsSupport = true,
  generateConstructorsPromptSupport = true,
  generateDelegateMethodsPromptSupport = true,
  moveRefactoringSupport = true,
  inferSelectionSupport = { 'extractMethod', 'extractVariable', 'extractConstant' },
}

return M
