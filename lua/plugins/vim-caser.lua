--=====================================================================
--
-- vim-caser.lua -
--
-- Created by liubang on 2023/11/26 16:13
-- Last Modified: 2023/11/26 16:13
--
--=====================================================================

return {
  -- MixedCase/PascalCase:   gsm/gsp
  -- camelCase:              gsc
  -- snake_case:             gs_
  -- UPPER_CASE:             gsu/gsU
  -- Title Case:             gst
  -- Sentence case:          gss
  -- space case:             gs<space>
  -- dash-case/kebab-case:   gs-/gsk
  -- Title-Dash/Title-Kebab: gsK
  -- dot.case:               gs.
  "arthurxavierx/vim-caser",
  keys = { { "gs", mode = { "n", "x" } } },
}
