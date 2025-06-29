return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      vim.list_extend(opts.sources, {
        { name = "path" },
        { name = "buffer" },
        { name = "luasnip" },
      })

      local cmp = require "cmp"
      local luasnip = require "luasnip"

      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })

      return opts
    end,
  },
}
