--=====================================================================
--
-- neogit.lua -
--
-- Created by liubang on 2022/12/31 02:40
-- Last Modified: 2022/12/31 02:40
--
--=====================================================================
return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  config = {
    kind = "split",
    signs = {
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = { diffview = true },
  },
}
