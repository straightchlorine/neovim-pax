-- headlines.nvim
-- https://github.com/lukas-reineke/headlines.nvim

return {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  ft = { "markdown", "norg", "rmd", "org" },
  config = function()
    require("headlines").setup({
      markdown = {
        query = vim.treesitter.query.parse(
          "markdown",
          [[
            (atx_heading [
                (atx_h1_marker)
                (atx_h2_marker)
                (atx_h3_marker)
                (atx_h4_marker)
                (atx_h5_marker)
                (atx_h6_marker)
            ] @headline)

            (thematic_break) @dash

            (fenced_code_block) @codeblock

            (block_quote_marker) @quote
            (block_quote (paragraph (inline (block_quote_marker) @quote)))
            (block_quote (paragraph (block_quote_marker) @quote))
            (block_quote (block_quote_marker) @quote)
        ]]
        ),
        headline_highlights = { "Headline" },
        bullet_highlights = {
          "@neorg.headings.1.marker",
          "@neorg.headings.2.marker",
          "@neorg.headings.3.marker",
          "@neorg.headings.4.marker",
          "@neorg.headings.5.marker",
          "@neorg.headings.6.marker",
        },
        bullets = { "◉", "○", "✸", "✿" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = true,
        fat_headline_upper_string = "▃",
        fat_headline_lower_string = "🬂",
      },
      rmd = {
        query = vim.treesitter.query.parse(
          "markdown",
          [[
            (atx_heading [
                (atx_h1_marker)
                (atx_h2_marker)
                (atx_h3_marker)
                (atx_h4_marker)
                (atx_h5_marker)
                (atx_h6_marker)
            ] @headline)

            (thematic_break) @dash

            (fenced_code_block) @codeblock

            (block_quote_marker) @quote
            (block_quote (paragraph (inline (block_quote_marker) @quote)))
            (block_quote (paragraph (block_quote_marker) @quote))
            (block_quote (block_quote_marker) @quote)
        ]]
        ),
        treesitter_language = "markdown",
        headline_highlights = { "Headline" },
        bullet_highlights = {
          "@neorg.headings.1.marker",
          "@neorg.headings.2.marker",
          "@neorg.headings.3.marker",
          "@neorg.headings.4.marker",
          "@neorg.headings.5.marker",
          "@neorg.headings.6.marker",
        },
        bullets = { "◉", "○", "✸", "✿" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = true,
        fat_headline_upper_string = "▃",
        fat_headline_lower_string = "🬂",
      },
      norg = {
        query = vim.treesitter.query.parse(
          "norg",
          [[
            [
                (heading1_prefix)
                (heading2_prefix)
                (heading3_prefix)
                (heading4_prefix)
                (heading5_prefix)
                (heading6_prefix)
            ] @headline

            (weak_paragraph_delimiter) @dash
            (strong_paragraph_delimiter) @doubledash

            (((ranged_tag
                name: (tag_name) @_name
                (#eq? @_name "code")
            ) @codeblock)
            (#offset! @codeblock 0 0 1 0))

            (quote1_prefix) @quote
        ]]
        ),
        headline_highlights = { "Headline" },
        bullet_highlights = {
          "@neorg.headings.1.marker",
          "@neorg.headings.2.marker",
          "@neorg.headings.3.marker",
          "@neorg.headings.4.marker",
          "@neorg.headings.5.marker",
          "@neorg.headings.6.marker",
        },
        bullets = { "◉", "○", "✸", "✿" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        doubledash_highlight = "DoubleDash",
        doubledash_string = "=",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = true,
        fat_headline_upper_string = "▃",
        fat_headline_lower_string = "🬂",
      },
      org = {
        query = vim.treesitter.query.parse(
          "org",
          [[
            (headline (stars) @headline)

            (
                (expr) @dash
                (#match? @dash "^-----+$")
            )

            (block
                name: (expr) @_name
                (#match? @_name "(SRC|src)")
            ) @codeblock

            (paragraph . (expr) @quote
                (#lua-match? @quote "^>+%s")
            )
        ]]
        ),
        headline_highlights = { "Headline" },
        bullet_highlights = {
          "@org.headline.level1",
          "@org.headline.level2",
          "@org.headline.level3",
          "@org.headline.level4",
          "@org.headline.level5",
          "@org.headline.level6",
          "@org.headline.level7",
          "@org.headline.level8",
        },
        bullets = { "◉", "○", "✸", "✿" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = true,
        fat_headline_upper_string = "▃",
        fat_headline_lower_string = "🬂",
      },
    })
  end,
}