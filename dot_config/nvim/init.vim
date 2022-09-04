colorscheme evening

" Tab settings
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

filetype on
filetype plugin on

set modeline

set rtp+=~/.config/nvim

" Yank into clipboard
set clipboard+=unnamedplus

" Confirmation on exit with modified unsaved file
set confirm

" Numerate lines by default
set number
map <F7> :set invnumber<CR>
imap <F7> <C-O>:set invnumber<CR>

" Case insensitive search
set ignorecase smartcase

" Enable TRUE COLOR support
set termguicolors
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Fold markdown by default
let g:markdown_folding = 1

" Toggle folding column with F2
map  <F2> :call ToggleFoldColumn()<CR>
imap <F2> <C-O>:call ToggleFoldColumn()<CR>
function ToggleFoldColumn()
	if &foldcolumn == 0
		set foldcolumn=1
	else
		set foldcolumn=0
	endif
endfunction


set fillchars=vert:│

" Tell (neo)Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
map <F5> :set invlist<CR>
imap <F5> <C-O>:set invlist<CR>

" Highlight trailing whitespaces
augroup highlighting
	autocmd BufRead * highlight ExtraWhitespace ctermbg=red guibg=#ff9a13
	autocmd BufRead * match ExtraWhitespace /\s\+$/
augroup END

" Status line
set statusline=
	\%f%<\ %y%w%h%m%r%{FormattedFileEncoding()}%{FormattedFileFormat()}%=
	\[%c%V][%l/%L\ %p%%\ %P]
function FormattedFileEncoding()
	if ( &fileencoding != '' ) && ( &fileencoding != &encoding )
		return '['.&fileencoding.']'
	else
		return ''
	endif
endfunction
function FormattedFileFormat()
	if &fileformat != 'unix'
		return '['.&fileformat.']'
	else
		return ''
	endif
endfunction

call plug#begin('~/.vim/plugged')
""
" To research
"let g:netwr_keepj = ""
"let g:netwr_scp_cmd="scp -q -O"
"set sync fromstart

set mouse=a

" Jump to search results while typing.
set hlsearch
set incsearch

" Spelling.
set spelllang=en,ru

" blame inside nvim + automatic ctags generation so cool!
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'bakpakin/janet.vim'
Plug 'https://git.sr.ht/~sircmpwn/hare.vim'
Plug '~/repo/mercury/vim'
Plug 'khaveesh/vim-fish-syntax'
"Plug 'https://github.com/tpope/vim-vinegar.git'
"Plug 'https://github.com/scrooloose/nerdtree.git'
"Plug 'https://github.com/scrooloose/nerdcommenter.git'

call plug#end()

autocmd BufReadPost *
\	if &l:readonly |
\		setlocal nomodifiable |
\	endif

autocmd FileType mail,gitcommit
\	set spell

autocmd FileType ada
\	set tabstop=3 shiftwidth=3

" surround line with first arg
"function! s:Surr(c)
"    exe 's/\%V\(.*\)\%V/' . a:c . '\1' . a:c . '/'
"endfunction

command! -nargs=1 WrapSelection call s:Surr(<f-args>)

" Mercury plugin settings.
let mercury_highlight_full_comment = 1
let mercury_highlight_extra = 1
let mercury_folding = 1

" wanna give this a try
" http://www.linusakesson.net/programming/syntaxhighlighting/index.php
" syntax off

" Set executable permissions for files with certain extensions.
autocmd BufWritePre *.sh,*.bash,*.py
\	if !filereadable(expand('%')) |
\		let b:is_new = 1 |
\	endif
autocmd BufWritePost *.sh,*.bash,*.py
\	if get(b:, 'is_new', 0) |
\		call setfperm(expand('%'), "rwxr-xr-x") |
\		let b:is_new = 0 |
\	endif

autocmd BufNewFile *.py
\	call append(0, ['#!/usr/bin/python', ''])

autocmd BufNewFile *.sh
\	call append(0, ['#!/bin/sh -e', '', 'set -euo pipefail', ''])

autocmd BufNewFile *.bash
\	call append(0, ['#!/bin/bash -e', '', 'set -euo pipefail', ''])

autocmd BufNewFile *.m
\	call append(0, [
\		'%---------------------------------------------------------------------------%',
\		'% vim: ts=4 sw=4 et ft=mercury',
\		'%---------------------------------------------------------------------------%',
\		'',
\		':- module ' . expand('%:r') . '.',
\		':- interface.',
\		':- implementation.',
\		'%---------------------------------------------------------------------------%',
\		':- end_module ' . expand('%:r') . '.',
\		'%---------------------------------------------------------------------------%'])


function ManMode()
	nnoremap <buffer> <ESC><ESC> :q!<CR>
	nnoremap <buffer> q :q!<CR>
	noremap <buffer> <S-UP> <UP>
	noremap <buffer> <S-DOWN> <DOWN>
	noremap <buffer> <UP> <C-Y>
	noremap <buffer> <DOWN> <C-E>
	noremap <buffer> <SPACE> <C-D>
	noremap <buffer> b <C-U>
endfunction

autocmd FileType man
\	call ManMode()
