--=====================================================================
--
-- opts.lua -
--
-- Created by liubang on 2022/09/18 20:36
-- Last Modified: 2022/09/18 20:36
--
--=====================================================================
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
  inferSelectionSupport = { "extractMethod", "extractVariable", "extractConstant" },
}

return M
