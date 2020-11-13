" How many columns a tab counts for
set tabstop=4

" How many columns text is indented with reindent ops: << and >>
set shiftwidth=4

" Make backspace treat four spaces like a tab.
set softtabstop=4

" Make tabs be spaces
set expandtab

" I see errors from this when keeping gvim running on a Chromebook.
set noswapfile

autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.html.ep setlocal tabstop=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.html.ep setlocal shiftwidth=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.html.ep setlocal softtabstop=2

autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.tmpl setlocal tabstop=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.tmpl setlocal shiftwidth=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.tmpl setlocal softtabstop=2

autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.js setlocal tabstop=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.js setlocal shiftwidth=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.js setlocal softtabstop=2

autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.go setlocal tabstop=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.go setlocal shiftwidth=2
autocmd BufRead,BufWinEnter,WinEnter,TabEnter,BufNewFile *.go setlocal softtabstop=2

if has("gui_running")
	set guifont=Inconsolata\ Medium\ 12
endif
