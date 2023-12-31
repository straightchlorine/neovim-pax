--- cmp.lua
-- Configuration for nvim-cmp plugin.
---

local cmp = require'cmp'

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },
  window = {
    --completion = cmp.config.window.bordered(),
    --documentation = cmp.config.window.bordered(),
  },
  mapping = {

    ['<Tab>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn['UltiSnips#CanJumpForwards']() == 1 then
          vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_forward)'), 'm', true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn['UltiSnips#CanJumpForwards']() == 1 then
          vim.api.nvim_feedkeys(t('<Plug>(ultisnips_jump_forward)'), 'm', true)
        else
          fallback()
        end
      end
    }),

    ['<S-Tab>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
          return vim.api.nvim_feedkeys( t('<Plug>(ultisnips_jump_backward)'), 'm', true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
          return vim.api.nvim_feedkeys( t('<Plug>(ultisnips_jump_backward)'), 'm', true)
        else
          fallback()
        end
      end
    }),

    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), {'i'}),

    ['<C-n>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),

    ['<C-p>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),

    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
    ['<C-e>'] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),

    ['<CR>'] = cmp.mapping({
      i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
          fallback()
        end
      end
    }),
  },

  formatting = {
    format = require('lspkind').cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50,
      preset = 'codicons',
      ellipsis_char = '...',
      symbol_map = { Copilot = "" },
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'ultisnips' },
    { name = 'cmp_nvim_r' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'copilot'},
  }),

  sorting = {
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
    }
  }
})

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  completion = { autocomplete = false },
  sources = {
    { name = 'buffer',
      opts = {
        keyword_pattern = [=[[^[:blank:]].*]=]
      }
    }
  }
})

cmp.setup.cmdline(':', {
  completion = { autocomplete = false },
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
