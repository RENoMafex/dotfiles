
" An example for a vimrc file.
"
" Maintainer:	The Vim Project <https://github.com/vim/vim>
" Last Change:	2023 Aug 10
" Former Maintainer:	Bram Moolenaar <Bram@vim.org>
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

syntax on

set number
set relativenumber
set modeline

set backupdir=~/vimtmp//,.
set directory=~/vimtmp//,.
set undodir=~/vimtmp//,.

set laststatus=2

set tabstop=4
set shiftwidth=4

set listchars=eol:$,trail:~,lead:~,extends:>,precedes:<,tab:-->
set encoding=UTF-8

set background=dark

set termguicolors

let g:onedark_terminal_italics=1

" colorscheme onedark

function! s:RENoMafexColorscheme ()
	highlight Normal		guifg=#ababab guibg=#000000 gui=NONE
	highlight LineNr		guifg=#ffff00				gui=NONE
	highlight Comment		guifg=#5c6370				gui=italic
	highlight SpecialKey	guifg=#1f1f1f				gui=NONE
	highlight! link NonText SpecialKey
	highlight Constant		guifg=#00c0c0				gui=NONE
	highlight Identifier	guifg=#00ffff				gui=bold
	highlight Statement		guifg=#ffff30
	autocmd FileType c,cpp \
		highlight PreProc	guifg=#ff0000
	highlight Type			guifg=#22ff22

endfunction

call s:RENoMafexColorscheme()

" needs airline plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
