--- lsp.lua
-- Configuration for nvim-lspconfig.
---

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Adjustment to the capabilities for nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
  documentationFormat = { 'markdown', 'plaintext', 'html' }
}

---
-- Language servers
---

local language_servers = {
  'arduino_language_server',
  'asm_lsp',
  'awk_ls',
  'bashls',
  'cmake',
  'dockerls',
  'ghdl_ls',
  'gopls',
  'kotlin_language_server',
  'marksman',
  'texlab',
  'please',
  'pyright',
  'rust_analyzer',
  'r_language_server',
  'sqlls',
  'verible',
  'vimls'
}

for _, ls in ipairs(language_servers) do
  lspconfig[ls].setup({
    capabilities = capabilities
  })
end

-- Enabling snippet support for cssls
local cssls_capabilities = capabilities
cssls_capabilities.textDocument.completion.snippetSupport = true

lspconfig.cssls.setup {
  capabilities = cssls_capabilities
}

lspconfig.gradle_ls.setup {
  capabilities = capabilities,
  cmd = { os.getenv('GRADLE_LANGUAGE_SERVER') },
}

lspconfig.groovyls.setup{
  capabilities = capabilities,
  cmd = { 'java', '-jar', os.getenv('GROOVY_LANGUAGE_SERVER') },
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          diagnostics = {
            globals = {
              'vim',
              'awesome'
            }
          },
          workspace = {
            library = {
              [vim.fn.expand '$VIMRUNTIME/lua'] = true,
              [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
              [vim.fn.expand '/usr/share/awesome'] = true,
              [vim.fn.expand '/usr/share/lua/5.4/lgi'] = true,
              [vim.fn.expand '/usr/share/lua/5.4/lgi/override'] = true,
              [vim.fn.expand '/usr/share/lua/5.4/luarocks'] = true
            }
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        }
      })
      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

-- Configuration for metals
local metals_config = require('metals').bare_config()
metals_config.settings = {
  showImplicitArguments = true,
}
metals_config.capabilities = capabilities

-- Configuration for clangd
lspconfig.clangd.setup {
  capabilities = capabilities,
  cmd = { 'clangd', '--background-index', '--offset-encoding=utf-16' },
}

---
-- Global mappings
---
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

---
-- Local mappings
---
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
