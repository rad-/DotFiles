colorscheme desert
highlight Normal ctermfg=grey ctermbg=black
set background=dark
let asmsyntax='armasm' 
let filetype_inc='armasm'
set tabstop=2
set shiftwidth=4
set number 
set ai
syntax on
set smartindent
set backspace=indent,eol,start
:filetype indent on
set hlsearch 
:map <F3> :set hlsearch!<CR>
set guioptions-=T "remove toolbar
set mouse=a
set encoding=utf8


"
" Vundle stuff
"
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" GITS
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tomtom/tlib_vim'
Plugin 'vimoutliner/vimoutliner'
Plugin 'sudar/vim-arduino-syntax'
"Plugin 'quark-zju/vim-cpp-auto-include'
Plugin 'godlygeek/tabular'
Plugin 'rdnetto/YCM-Generator', {'branch' : 'stable'}
Plugin 'szw/vim-tags'
"	Open nerd tree with F9
Plugin 'scrooloose/nerdtree'




"VIM website

Plugin 'AutoCpp'
Plugin 'Atom'


call vundle#end()

" 
" word processor mode
"
let Tlist_Use_Right_Window = 1

"func! WordProcessorMode() 
"	setlocal formatoptions=1 
"	setlocal noexpandtab 
"	map j gj 
"	map k gk
"	setlocal spell spelllang=en_us 
"	"set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
"	set complete+=s
"	set formatprg=par
"	setlocal wrap 
"	setlocal linebreak 
"endfu 
"com! WP call WordProcessorMode()


"
"	Vim tags
"
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore', 'Docs']
set autochdir
set tags=./tags,tags;$HOME
" Ctrl + \  :: open in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Alt + ] 	:: open in Vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"
" tpope gist to automatically maintain tabs while typing
"
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a


" Use by selecting all text which you desire to align.
" Then use `:` `Tabularize /{symbol to align on}`
function! s:align()
	let p = '^\s*|\s.*\s|\s*$'
	if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
		let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
		let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
		Tabularize/|/l1
		normal! 0
		call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
	endif
endfunction

" disable clang_complete and SuperTab in favor of youcompleteme

"let g:clang_use_library=1
func! StartClangComplete()
	let g:clang_debug=1
	"On Ubuntu, libllvm.so is not located in /usr/lib/
	"On ubuntu, you must install libclang1-dev in order to get
	"/usr/lib/libclang.so
	let g:clang_library_path='/usr/lib/llvm-3.4/lib/'
	let g:clang_auto_select=1 
	set conceallevel=2
	set concealcursor=vin
	let g:clang_snippets=1
	let g:clang_conceal_snippets=1

	" The single one that works with clang_complete
	let g:clang_snippets_engine='clang_complete'
	" show errors in code
	"let g:clang_complete_copen = 1
	let g:clang_hl_errors=1
	"let g:clang_periodic_quickfix=1
	"nmap <F5> call g:ClangUpdateQuickFix()
	"
	" Complete options (disable preview scratch window, longest removed to aways
	" show menu)
	set completeopt=menu,menuone
	" Limit popup menu height
	set pumheight=20
endfu
com! StartClang call StartClangComplete()


" SuperTab completion fall-back 
let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'
"let g:tex_flavor='latex'
"let g:Tex_DefaultTargetFormat='pdf'
set nocp

let g:acp_behaviorSnipmateLength = 1

nmap <F8> :TagbarToggle<CR>
nmap <F9> :NERDTreeToggle<CR>
" use F3 to toggle highlighting of search strings

:map <C-h> :MBEbp<CR>
:map <C-l> :MBEbn<CR>


" use :call SwapWords({'foo':'bar'}) to swap
" foo with bar and bar with foo.
" NOTE: 
" If one of your words contains a /, you have to pass in a delimiter
" which you know none of your words contains, .e.g
" :call SwapWords({'foo/bar':'foo/baz'}, '@')
" 
function! SwapWords(dict, ...)
		let words = keys(a:dict) + values(a:dict)
		let words = map(words, 'escape(v:val, "|")')
		if(a:0 == 1)
				let delimiter = a:1
		else
				let delimiter = '/'
		endif
		let pattern = '\v(' . join(words, '|') . ')'
		exe '%s' . delimiter . pattern . delimiter
								\ . '\=' . string(Mirror(a:dict)) . '[S(0)]'
								\ . delimiter . 'g'
endfunction




filetype plugin on
filetype plugin indent on
highlight Normal ctermfg=grey ctermbg=black




