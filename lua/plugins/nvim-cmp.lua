-- nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-cmdline",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      config = function()
        local ls = require("luasnip")
        vim.keymap.set({ "i", "s" }, "<C-L>", function()
          ls.jump(1)
        end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-J>", function()
          ls.jump(-1)
        end, { silent = true })

        vim.api.nvim_create_autocmd("ModeChanged", {
          pattern = "*",
          callback = function()
            if
              ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
              and ls.session.current_nodes[vim.api.nvim_get_current_buf()]
              and not ls.session.jump_active
            then
              ls.unlink_current()
            end
          end,
        })
      end,
    },
    "saadparwaiz1/cmp_luasnip",
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
    },
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",
    {
      "zbirenbaum/copilot-cmp",
      dependencies = { "zbirenbaum/copilot.lua" },
      config = function()
        require("copilot").setup()
        require("copilot_cmp").setup()
      end,
    },
    "folke/lazydev.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local compare = require("cmp.config.compare")
    local types = require("cmp.types")

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    require("luasnip.loaders.from_vscode").lazy_load()

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp", group_index = 1, priority = 1000 },
        { name = "copilot", group_index = 1, priority = 900 },
        { name = "nvim_lsp_signature_help", group_index = 1, priority = 800 },
        { name = "lazydev", group_index = 0, priority = 1100 },
        { name = "luasnip", group_index = 1, priority = 750 },
        { name = "path", group_index = 1, priority = 500 },
        {
          name = "buffer",
          group_index = 2,
          priority = 250,
          keyword_length = 3,
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end,
          },
        },
      }),
      window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          max_width = 50,
          symbol_map = { Copilot = "" },
          before = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              copilot = "[Copilot]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
              lazydev = "[LazyDev]",
              nvim_lsp_signature_help = "[Signature]",
            })[entry.source.name]
            return vim_item
          end,
        }),
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          compare.score,
          compare.recently_used,
          compare.offset,
          compare.exact,
          compare.kind,
          compare.sort_text,
          compare.length,
          compare.order,
        },
      },
      performance = {
        max_view_entries = 20,
      },
      experimental = {
        ghost_text = true,
      },
    })

    -- `/` cmdline setup.
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
