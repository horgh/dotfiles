" This must be first because it changes other options as a side effect.
set nocompatible


" github.com/junegunn/vim-plug plugin manager

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'Shutnik/jshint2.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown'
Plug 'dense-analysis/ale'

" This is a fork of yko/mojo.vim as upstream has an issue where it parses
" HTML inside curly braces as Perl.
Plug 'rsrchboy/mojo.vim'

call plug#end()

" Enable modeline magic (vim: lines). This defaults to on except if you're root.
set modeline

" Dynamic title
set title

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set background=light

" Keep 50 lines of command line history
set history=50

" Show the cursor position all the time
set ruler

" Display incomplete commands
set showcmd

" Do incremental searching
set incsearch

" Ignore case for / searching unless there is a capital
set ignorecase
set smartcase

" When scroll below, start scrolling 3 lines before bottom
set scrolloff=3

" Autoindent stuff
set autoindent

" Always show the status line in the last window
set laststatus=2

" Status line content.
" %f = relative path to file.
" %M = modified flag. e.g., +
" %R = readonline flag. e.g. RO
" %Y = file type. e.g., VIM
" %b = decimal value of character
" %B = hexidecimal value of character
" %l = line number
" %L = number of lines in buffer
" %c = column number
" %p = percentage through file in lines
" %= = sets where left/right justification split occurs
set statusline=%f\ %M%R%Y\ %{&fileformat}\ %{GetIndentationState()}\ %=%b:%B\ \ \ %l,%c/%L\ %3p%%

" Allow tab completion of :commands
set wildmenu

" Highlight parts of line over 79 chars in length. (80th and on)
" See help term, help highlight
" Another option is to have instead of match OverLength, use match ErrorMsg
" which uses error colouring
highlight OverLength gui=italic,underline,bold

" To turn this off, use:
" highlight clear OverLength

" So... we appear to be only able to call "match" once and subsequent
" overwrite. To get around this we can use 2match and 3match instead
" of plain "match". I'm not sure how this works with many plugins loaded...
" There is also matchadd() but I can't seem to get it working with a regex.
"
" Why use autocmd instead of just 2match directly? It seems as though
" matches get cleared under certain circumstances so this tries to ensure
" that it gets re-added. for example, without it and using 2match on its
" own, open a file, and then :vsp the same file. One will no longer have
" the matching.
autocmd BufEnter,BufWinEnter,WinEnter,TabEnter * 2match OverLength /\%>80v.\+/

" .roff for rfc. 72 chars max
autocmd BufEnter,BufWinEnter,WinEnter,TabEnter *.roff 2match OverLength /\%>72v.\+/

" vim-better-whitespace colouring.
highlight ExtraWhitespace guifg=blue guibg=red gui=underline

" For more info on these, see :help fo-table
" t = auto-wrap text using textwidth
" c = auto-wrap comments using textwidth, inserting the current
"     comment leader automatically
" r = Automatically insert the current comment leader after hitting
"     <Enter> in Insert mode.
" o = Automatically insert the current comment leader after hitting 'o' or
"     'O' in Normal mode.
" q = Allow formatting of comments with 'gq'.
" n = Recognize lists, and auto indent. With an appropriate formatlistpat
"     this means we autoindent like the following:
"     * My list item
"       Indented to here
"     Note this auto indenting works only when wrapping to the next line. I
"     have not been able to get it to work when just hitting enter.
set formatoptions+=tcroqn

" formatlistpat is the pattern used by formatoptions n. The default is:
" ^\s*\d\+[\]:.)}\t ]\s* which recognizes numbered lists.
"
" Mine recognizes:
" 1. hi
" * hi
" - hi
"
" I use let to avoid needing to have the excessive escaping that set does (which
" requires escaping backslash and spaces).
let &formatlistpat='^\s*\(\*\|-\|\d\+\.\)\s*'

set encoding=utf-8

" Only open files as UTF-8. The default is to try several different encodings
" and it can lead to opening files in something than UTF-8 if there is invalid
" UTF-8 in the file. Even if that's the case I want UTF-8. I never want to
" open by default. I want to have to choose that.
set fileencodings=utf-8

" Always show the tab section/line.
" This applies in both gui and cli mode.
set showtabline=2

" Do not insert two spaces when joining/reformatting.
" This occurs, for example, when using 'gq'.
set nojoinspaces

syntax on

" Make syntax highlighting more correct by scanning the entire file. Otherwise
" what can happen is syntax highlighting can make mistakes.
" NOTE: This is mentioned as being high resource use.
" See http://vim.wikia.com/wiki/Fix_syntax_highlighting
autocmd BufEnter,BufWinEnter,WinEnter,TabEnter * :syntax sync fromstart

" This function is to build a string about indentation mode that I can show in
" the status bar. Why? Because I have found occasionally that my indentation
" mode changes unexpectedly (loading a new file). I have not determined exactly
" why/when this occurs. This is so I can be aware of it.
" ! prefix to function means to overwrite it if it exists
" abort to abort if error immediately
function! GetIndentationState() abort
	let s = ""
	if &expandtab
		let s .= "space"
	else
		let s .= "tab"
	endif

	let s .= ":"
	let s .= &tabstop
	let s .= ":"
	let s .= &shiftwidth
	return s
endfunction

" Run syntax sync and say something about it (just so I'm sure it actually ran)
function! ResyncSyntax() abort
	syntax sync fromstart
	echo "Resynced syntax"
endfunction

filetype plugin on
filetype indent on

" Bindings to advance to previous/next error.
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

" vim-markdown: Disable the auto folding.
let g:vim_markdown_folding_disabled = 1

" jshint2.vim settings
" Lint after save.
let jshint2_save = 1

" Use urxvt instead of xterm (:FZF)
let g:fzf_launcher = 'urxvt -geometry 120x30 -e sh -c %s'


" ale
let g:ale_linters = {'go':['gofmt','golint','go vet','golangci-lint']}

let g:ale_go_gofmt_options = '-s'

let g:ale_go_golangci_lint_options = '--exclude-use-default=false'
let g:ale_go_golangci_lint_package = 1

let g:ale_fixers = {'go':['gofmt','goimports']}
let g:ale_fix_on_save = 1

" Only run linters I define. Otherwise it enables a bunch of others by default
" which can recommend incorrect things, e.g. YAML linter which conflicts with
" what the repo might enforce.
let g:ale_linters_explicit = 1

" Navigate between errors.
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


"
" Global mappings.
"

" Don't use Ex mode, use Q for formatting
map Q gq

" Map a key to force syntax resync
map <C-t>s :call ResyncSyntax()<cr>

" Tab maps
" Go to first tab
map <C-t>k :tabr<cr>
" Go to last tab
map <C-t>j :tabl<cr>
" Go to next tab
map <C-t>l :tabn<cr>
" Go to prev tab
map <C-t>h :tabp<cr>
map <A-1> :tabn 1<cr>
map <A-2> :tabn 2<cr>
map <A-3> :tabn 3<cr>
map <A-4> :tabn 4<cr>
map <A-5> :tabn 5<cr>
map <A-6> :tabn 6<cr>
map <A-7> :tabn 7<cr>
map <A-8> :tabn 8<cr>
map <A-9> :tabn 9<cr>
map <A-0> :tabn 0<cr>

" Save from insert mode: ^s
inoremap <C-s> <c-o>:w<cr>

" Let alt+1 go to first tab, etc. This is for regular vim. gvim does already.
"
" For iTerm2 (macOS) we need to set option/alt to send +ESC.

" First define M-n to send ESC then a number. This is what pressing alt and a
" key sends in many terminals. See :help map's section about alt for more info.
" There is also info under :help set. Search for M-b there.

" Then make the alt+n change tabs.
noremap 1 1gt
noremap 2 2gt
noremap 3 3gt
noremap 4 4gt
noremap 5 5gt
noremap 6 6gt
noremap 7 7gt
noremap 8 8gt
noremap 9 9gt


"
" Indentation options.
"

" Tab indentation.

" How many columns a tab counts for
set tabstop=2

" How many columns text is indented with reindent ops: << and >>
set shiftwidth=2

" Keep tabs as tabs.
set noexpandtab


" Space indentation.

" How many columns a tab counts for
"set tabstop=4

" How many columns text is indented with reindent ops: << and >>
"set shiftwidth=4

" Make backspace treat four spaces like a tab.
"set softtabstop=4

" Make tabs be spaces
"set expandtab


"
" Per filetype options.
"

autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.json setlocal expandtab
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.xml setlocal expandtab
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.conf setlocal expandtab

" https://github.com/rubocop-hq/ruby-style-guide suggests 2 spaces.
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile Rakefile setlocal tabstop=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile Rakefile setlocal shiftwidth=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile Rakefile setlocal softtabstop=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile Rakefile setlocal expandtab
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.rb setlocal tabstop=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.rb setlocal shiftwidth=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.rb setlocal softtabstop=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.rb setlocal expandtab

autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.yml setlocal tabstop=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.yml setlocal shiftwidth=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.yml setlocal softtabstop=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.yml setlocal expandtab

" For plaintext type files, update formatoptions to not include any that deal
" with comments, and disable comments. Otherwise vim treats characters like '-'
" and '*' as being a comment character, which by default sets an increased
" comment level. See :help fo-table. I do this where I set formatoptions to tn,
" below.
"
" Even with only disabling formatoptions related to comments, there is odd
" behaviour with certain characters in the formatlistpat. Both * (as \*) and -
" (as -) don't work as expected. After fighting with this for a while, I found
" a reddit comment where someone talked about them being treated as comments.
" To not treat them as comments, use 'set comments='.

autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.txt
			\ setlocal expandtab |
			\ setlocal textwidth=75 |
			\ setlocal formatoptions=tn |
			\ setlocal comments=

autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.tex
			\ setlocal textwidth=75

autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile README
			\ setlocal expandtab |
			\ setlocal textwidth=75 |
			\ setlocal formatoptions=tn |
			\ setlocal comments=

" I used to have noautoindent on Markdown files. I'm not sure why.
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.md
			\ setlocal expandtab |
			\ setlocal textwidth=75 |
			\ setlocal formatoptions=tn |
			\ setlocal comments=

" PostgreSQL does not like tabs.
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.sql
			\ setlocal expandtab

" Go standard is to use tabs. In case I use space indentation in some places,
" include this explicitly.
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.go
			\ setlocal noexpandtab

" Makefiles require tabs. In case I use space indentation in some places,
" include this explicitly.
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile Makefile
			\ setlocal noexpandtab


autocmd BufReadPost *.ts setlocal syntax=javascript


"
" gvim/vim only options.
"

if has("gui_running")
	colorscheme proton

	" Remove menu bar
	set guioptions-=m

	" Remove toolbar
	set guioptions-=T

	" Remove right-hand scroll bar
	set guioptions-=r

	" Remove left scroll bar
	set guioptions-=L

	set guifont=Inconsolata\ Medium\ 14

	" Let mouse work for things like clicking to move cursor.
	set mouse=a
else
	colorscheme proton-cterm
	set t_Co=256 " Tell vim the terminal supports 256 colours.
	set mouse-=a
endif

if filereadable($HOME . '/.vim/env.vim')
	execute "source " . $HOME . "/.vim/env.vim"
endif
