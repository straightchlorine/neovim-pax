return {
	"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_view_general_viewer = "zathura"
		vim.g.vimtex_complete_enabled = 1
		vim.g.vimtex_comlete_bib = "simple"

		vim.cmd([[
			let g:vimtex_compiler_latexmk = {
				\ 'build_dir' : '',
				\ 'callback' : 1,
				\ 'continuous' : 1,
				\ 'executable' : 'latexmk',
				\ 'hooks' : [],
				\ 'options' : [
				\   '-shell-escape',
				\   '-verbose',
				\   '-file-line-error',
				\   '-synctex=1',
				\   '-interaction=nonstopmode',
				\   '-lualatex',
				\ ],
				\}
		]])

		vim.cmd([[
			let g:vimtex_syntax_conceal = {
				\ 'accents': 1,
				\ 'ligatures': 1,
				\ 'cites': 1,
				\ 'fancy': 1,
				\ 'spacing': 1,
				\ 'greek': 1,
				\ 'math_bounds': 1,
				\ 'math_delimiters': 1,
				\ 'math_fracs': 1,
				\ 'math_super_sub': 1,
				\ 'math_symbols': 1,
				\ 'sections': 1,
				\ 'styles': 1,
				\}
		]])
	end,
}
