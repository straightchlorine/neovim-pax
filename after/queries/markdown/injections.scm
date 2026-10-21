; extends
; MDX: highlight JSX/ESM inside markdown (from davidmh/mdx.nvim). .mdx is
; filetype markdown (lua/core/options.lua), so these ride the markdown parser.

((inline) @injection.content
  (#lua-match? @injection.content "^%s*import")
  (#set! injection.language "typescript"))

((inline) @injection.content
  (#lua-match? @injection.content "^%s*export")
  (#set! injection.language "typescriptreact"))

((inline) @injection.content
  (#lua-match? @injection.content "^<")
  (#set! injection.language "typescriptreact"))

((indented_code_block) @injection.content
  (#lua-match? @injection.content "^%s*<")
  (#set! injection.language "typescriptreact")
  (#set! injection.include-children))

((html_block) @injection.content
  (#set! injection.language "typescriptreact")
  (#set! injection.include-children))
