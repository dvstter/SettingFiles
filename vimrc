" SelfDefined remapping keys ---------- {{{
" this line just for fix some bugs on python3 imp module problem
if has("python3")
	silent! python3 1
endif

" make edit vimrc file more confortable
let mapleader = "-"
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" make enter and space to insert blank
nnoremap <CR> o<Esc>
nnoremap <Space> i<Space><Esc>l

" make quit easier
"nnoremap <leader>q :q!<CR>
"nnoremap <leader>w :x<CR>

" disable record function and turn it to quit program
function! QuitProgram()
	" the file has not been modified, quit directly
	if &modified == 0
		:q
	endif

	" the file has been modifed, ask before quit
	let choice = confirm("Quit?", "&No\n&Save\n&Discard")
	if choice == 1
	elseif choice == 2
		:wq
	else
		:q!
	endif
endfunction
nnoremap q :call QuitProgram()<Esc>

" make some abbreviations
iabbrev @@ p1usj4de@163.com
iabbrev ccopy Copyright 2018 Hanlin Yang, all rights reserved.

" remap the H, L, and make delete more easier
nnoremap H 0
nnoremap L $
nnoremap dH d0
nnoremap dL d$
nnoremap cH c0

" make <Esc> more confortable
inoremap jk <Esc>

augroup AutoInsertParenthesis
	autocmd!
	inoremap { {}<Left>
	inoremap {{ {
	inoremap {} {}

	inoremap [ []<Left>
	inoremap [[ [
	inoremap [] []

	inoremap ( ()<Left>
	inoremap (( (
	inoremap () ()

	inoremap < <><Left>
	inoremap << <
	inoremap <> <>

	inoremap " ""<Left>
	inoremap "" "

	inoremap ' ''<Left>
	inoremap '' '

	vnoremap ( c()<Esc>P
	vnoremap " c""<Esc>P
	vnoremap ' c''<Esc>P
	vnoremap < c<><Esc>P
augroup end

augroup PythonAutomation
	autocmd!
  autocmd BufNewFile,BufRead *.ipynb set filetype=jupyter
	autocmd FileType python,jupyter nnoremap # 0i#<Esc>j
  autocmd FileType python,jupyter nnoremap <Tab> ^i<Tab><Esc>j
augroup end
" }}}

" Vundle and plugin initializing settings ---------- {{{
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" install other plugins here
Bundle 'Valloric/YouCompleteMe'
Bundle 'taglist.vim'
Bundle 'scrooloose/nerdtree'
Plugin 'rdnetto/YCM-Generator'
Plugin 'flazz/vim-colorschemes'
Plugin 'JuliaEditorSupport/julia-vim'

" all of plugins must be added before the following line
call vundle#end()
filetype plugin indent on
" }}}

" Basic vim file settings ---------- {{{
" use gui color-set scheme
set encoding=utf-8
set backspace=indent,eol,start " more powerful backspacing
set termguicolors
hi clear
colorscheme wombat
set shortmess=atI
set showcmd
set number
set is
set autoread
set autoindent
syntax on
set hlsearch
highlight Search guibg=red
set wildmenu
set wildmode=full
set history=200
" to be consistent with PEP 8
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 expandtab

augroup HighlightInsertionLine
	autocmd!
	autocmd InsertLeave * se nocul
	autocmd InsertEnter * se cul
augroup end

augroup SetProgrammingComment
	autocmd!
	autocmd FileType python,shell setlocal commentstring=#\ %s
	autocmd FileType c,cpp,java setlocal commentstring=//\ %s
augroup end

augroup SetVimFoldMethod
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Settings for the NERDTree ---------- {{{
let NERDTreeWinPos="right"
let NERDTreeWinSize=30
map <F2> :NERDTreeToggle<CR>
"autocmd VimEnter * NERDTree
" }}}

" Settings for the taglist ---------- {{{
" set toggle hot-key for the taglist
nnoremap <silent> <F3> :TlistToggle<CR>

let Tlist_Ctags_Cmd="ctags"
" only show the current file's taglist
let Tlist_Show_One_File=1

" set taglist window width
let Tlist_WinWidt=28

" if taglist is the last window, quit the vim
let Tlist_Exit_OnlyWindow=1

" let the taglist window shows on the left
let Tlist_Use_Left_Windo=1

" let the taglist window auto-load
"let Tlist_Auto_Open=1
" }}}

" Settings for the YouCompleteMe ---------- {{{
" let vim's auto-complete function just like the normal IDE
set completeopt=longest,menu

" leave Insert Mode will close the preview window
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" ENTER means choose the current item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" enable YCM's engine based tag
let g:ycm_collect_identifiers_from_tags_files=1

" set the extra_conf file
let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"

" start to search matching item from the second character
let g:ycm_min_num_of_chars_for_completion=2

" ban cached matching items
let g:ycm_cache_omnifunc=0

" syntax identifiers match
let g:ycm_seed_identifiers_with_syntax=1

" enable auto-completetion even in the comments
let g:ycm_complete_in_comments=1

" enable auto-completetion even in the string
let g:ycm_complete_in_strings=1

" after input ENTER close the completion window
let g:ycm_key_list_stop_completion = ['<CR>']
" }}}
