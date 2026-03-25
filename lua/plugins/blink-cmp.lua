-- blink.cmp
-- https://github.com/Saghen/blink.cmp

return {
  "saghen/blink.cmp",
  version = "v0.*",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    {
      "zbirenbaum/copilot.lua",
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end,
    },
    {
      "giuxtaposition/blink-cmp-copilot",
    },
  },
  opts = {
    keymap = {
      preset = "none",
      ["<C-n>"] = { "show", "select_next", "fallback" },
      ["<C-p>"] = { "show", "select_prev", "fallback" },
      ["<C-y>"] = { "select_and_accept" },
      ["<C-e>"] = { "cancel", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    snippets = {
      expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction) require("luasnip").jump(direction) end,
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer", "copilot" },
      min_keyword_length = 2,
      providers = {
        lsp = {
          min_keyword_length = 0,
        },
        copilot = {
          name = "copilot",
          module = "blink-cmp-copilot",
          score_offset = 0,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
      },
    },

    completion = {
      trigger = {
        show_on_keyword = true,
        show_on_trigger_character = true,
      },

      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },

      accept = {
        create_undo_point = true,
        auto_brackets = {
          enabled = true,
        },
      },

      menu = {
        auto_show = true,
        border = "none",
        draw = {
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
        },
      },

      ghost_text = {
        enabled = true,
        show_with_selection = true,
        show_without_selection = false,
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = "rounded",
        },
      },
    },

    signature = { enabled = true },
  },

  opts_extend = { "sources.default" },
}