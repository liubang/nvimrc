--=====================================================================
--
-- nvim-navic.lua -
--
-- Created by liubang on 2022/12/30 22:08
-- Last Modified: 2022/12/30 22:08
--
--=====================================================================
return {
  "SmiteshP/nvim-navic",
  init = function()
    vim.g.navic_silence = true
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local buffer = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end,
    })
  end,
  opts = function()
    -- stylua: ignore
    local icons = { --{{{
      File          = " ",
      Module        = " ",
      Namespace     = " ",
      Package       = " ",
      Class         = " ",
      Method        = " ",
      Property      = " ",
      Field         = " ",
      Constructor   = " ",
      Enum          = " ",
      Interface     = " ",
      Function      = " ",
      Variable      = " ",
      Constant      = " ",
      String        = " ",
      Number        = " ",
      Boolean       = " ",
      Array         = " ",
      Object        = " ",
      Key           = " ",
      Null          = " ",
      EnumMember    = " ",
      Struct        = " ",
      Event         = " ",
      Operator      = " ",
      TypeParameter = " ",
    } --}}}

    return {
      -- stylua: ignore
      icons = {
        Array         = icons.array,
        Boolean       = icons.boolean,
        Class         = icons.class,
        Constant      = icons.constant,
        Constructor   = icons.constructor,
        Enum          = icons.enum,
        EnumMember    = icons.enumMember,
        Event         = icons.event,
        Field         = icons.field,
        File          = icons.file,
        Function      = icons.func,
        Interface     = icons.interface,
        Key           = icons.key,
        Method        = icons.method,
        Module        = icons.module,
        Namespace     = icons.namespace,
        Null          = icons.null,
        Number        = icons.number,
        Object        = icons.object,
        Operator      = icons.operator,
        Package       = icons.package,
        Property      = icons.property,
        String        = icons.string,
        Struct        = icons.struct,
        TypeParameter = icons.typeParameter,
        Variable      = icons.variable,
      },
      separator = " > ",
      -- separator = separator,
      depth_limit = 3,
      highlight = true,
      depth_limit_indicator = "..",
      safe_output = true,
    }
  end,
}
