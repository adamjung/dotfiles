set nocompatible
filetype off

" vim-plug  *****************************************************************
call plug#begin('~/.vim/plugged')
Plug 'benmills/vimux'
Plug 'bogado/file-line'
Plug 'dcosson/vimux-nose-test2'
Plug 'flowtype/vim-flow'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'juvenn/mustache.vim'
Plug 'kana/vim-fakeclip'
Plug 'mileszs/ack.vim'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'mattn/emmet-vim'
Plug 'nvie/vim-flake8'
Plug 'pgr0ss/vimux-ruby-test'
Plug 'plasticboy/vim-markdown'
Plug 'rkulla/pydiction'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/nerdtree'
Plug 'shime/vim-livedown'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/LanguageTool'
Plug 'vim-scripts/taglist.vim'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim' }
Plug 'jlanzarotta/bufexplorer'
Plug 'dense-analysis/ale'
call plug#end()

filetype plugin indent on

syntax on

" use either , or \ as <Leader>
let mapleader = ","
nmap \ ,

" source local customizations based on $USER name
" eg, use ~/.vimrc.jungmoney for your local mods
" and one common ~/.vimrc for team
if filereadable($HOME . '/.vimrc.' . $USER)
    exec ':source ' . $HOME . '/.vimrc.' . $USER
endif


" Basics ********************************************************************
set backspace=indent,eol,start
set number
set et
set sw=4
set smarttab
set incsearch
set hlsearch
set cursorline
set ignorecase
set smartcase
set title
set ruler
set showmode
set showcmd
set ai " Automatically set the indent of a new line (local to buffer)
set si


" airline *******************************************************************
set laststatus=2 " Show filename at bottom of buffer
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'wombat'

" ale ***********************************************************************
let g:ale_enabled = 1
nnoremap <leader>a :ALENextWrap<CR>

let g:ale_lint_on_text_changed = 'normal'
let g:ale_fix_on_save = 1

let g:airline#extensions#ale#enable = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters = {
\  'javascript': ['eslint'],
\  'jsx': ['eslint'],
\  'ruby': ['ruby', 'rubocop'],
\}

let g:ale_fixers = {
\  'javascript': ['prettier', 'remove_trailing_lines'],
\  'ruby': ['rubocop', 'remove_trailing_lines'],
\}

let g:ale_javascript_prettier_options = ' --single-quote --bracket-same-line --trailing-comma es5 --print-width 100'
let g:ale_javascript_eslint_use_global = 1

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal g`\"" |
    \ endif


" Folding *******************************************************************
" use spacebar to toggle folding
nnoremap <silent> <Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
vnoremap <Space> zf
" it's way too hard to type zR/zM to expand/close all folds, so
nnoremap 88 zR
nnoremap 77 zM


" Search ********************************************************************
set tags=./tags;
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case
    set grepformat=%f:%l:%c:%m
    let g:ackprg = 'rg --vimgrep --smart-case'
endif

" switch from horizontal to vertical split
command H2v normal <C-w>t<C-w>H
" switch from vertical to horizontal split
command V2h normal <C-w>t<C-w>K


" Completion ****************************************************************
autocmd FileType python set omnifunc=python3complete#Complete
autocmd FileType python setlocal list
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd Filetype javascript set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

set wildignore+=*/node_modules/*

" fzf ***********************************************************************

" Map ctrl + p to fzf fuzzy matcher, and customize colors to match vim
nmap <C-p> :FZF<CR>
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" Ack.vim  ******************************************************************
nmap <Leader>f :Ack 


" Buffers *******************************************************************
nmap <Leader>b :buffers<CR>
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
" make panes equal size
noremap <Leader>w <C-W>=


" CSS ***********************************************************************
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype scss setlocal ts=2 sts=2 sw=2


" HTML  *********************************************************************
autocmd Filetype html setlocal ts=2 sts=2 sw=2

" Javascript ****************************************************************
autocmd FileType javascript setlocal formatprg=prettier\ --stdin-filepath\ %\ --single-quote\ --bracket-same-line\ --trailing-comma\ es5\ --print-width\ 100


" Python ********************************************************************

" prevent comments from going to beginning of line
autocmd BufRead *.py inoremap # X<c-h>#
" turn on python folding when you open a file
autocmd BufRead *.py set foldmethod=indent
autocmd BufRead *.py set foldlevel=1
" configure pydiction
let g:pydiction_location = '~/.vim/plugged/pydiction/complete-dict'
noremap <Leader>d Oimport pdb; pdb.set_trace()<Esc>
au FileType python setlocal formatprg=autopep8\ -
au FileType python setlocal equalprg=autopep8\ -


" Ruby **********************************************************************
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2


" Git ***********************************************************************
" review git diff in a vertical split
nmap <Leader>dd :Gvdiffsplit<CR>


" Vimux  ********************************************************************
let g:vimux_ruby_file_relative_paths = 1
let g:vimux_nose_options="--nologcapture"

" vimux all languages
map <Leader>ri :call VimuxInspectRunner()<CR>
" e'X'it vimux
map <Leader>rx :call VimuxCloseRunner()<CR>
" last spec 'A'gain
map <Leader>ra :call VimuxRunLastCommand()<CR>
" vimux ruby
" 'S'pecs 'S'uite
autocmd FileType ruby   map <Leader>rs :call VimuxRunCommand("rspec")<CR>
" 'B'uffer
autocmd FileType ruby   map <Leader>rb :RunAllRubyTests<CR>
" 'L'ine
" autocmd FileType ruby   map <Leader>rl :RunRailsFocusedTest<CR>
autocmd FileType ruby   map <Leader>rl :call VimuxRunCommand("clear; RSPEC_CLEAN_WITH_DELETION=1 RSPEC_TRUNCATE_AFTER_SUITE=1 RSPEC_SKIP_ELASTICSEARCH_SETUP=1 ./bin/rspec " . expand("%.") . ":" . line("."))<CR>
" 'C'ontext
autocmd FileType ruby   map <Leader>rc :RunRubyFocusedContext<CR>
" vimux python
autocmd FileType python map <Leader>rt :call VimuxRunNoseSetup()<CR>
" 'S'pecs 'S'uite
autocmd FileType python map <Leader>rs :call VimuxRunNoseAll()<CR>
" 'B'uffer
autocmd FileType python map <Leader>rb :call VimuxRunNoseFile()<CR>
" 'L'ine
autocmd FileType python map <Leader>rl :call VimuxRunNoseLine()<CR>
" vimux js
" In one tab in docker, start karma and leave it running with
" xvfb-run $NODE_PATH/karma/bin/karma start --single-run=false
" 'L'ine
" autocmd FileType javascript map <Leader>rl :call VimuxRunCommand("clear; ./dev-scripts/karma-run-line-number.sh " . expand("%.") . ":" . line("."))<CR>
autocmd FileType javascript map <Leader>rl :call VimuxRunCommand("clear; ./dev-scripts/karma-start-single-run-line-number.sh " . expand("%.") . ":" . line("."))<CR>
" 'B'uffer
" autocmd FileType javascript map <Leader>rb :call VimuxRunCommand("clear; $NODE_PATH/karma/bin/karma run -- --grep=")<CR>
autocmd FileType javascript map <Leader>rb :call VimuxRunCommand("clear; xvfb-run ./node_modules/karma/bin/karma start --single-run=true --single-file=\"" . expand("%.") . "\"")<CR>


" Grammar  ******************************************************************
let s:brew_prefix = empty($HOMEBREW_PREFIX) ? '/opt/homebrew' : $HOMEBREW_PREFIX
let g:languagetool_jar = get(glob(s:brew_prefix . '/Cellar/languagetool/*/libexec/languagetool-commandline.jar', 0, 1), -1, '')

" Spelling ******************************************************************
set spellfile=~/.vim/spell/en.utf-8.add
nmap <Leader>s :setlocal spell! spelllang=en_us<CR>

" Theme *********************************************************************
colorscheme Tomorrow-Night

" Shortcuts *****************************************************************
imap <C-l> <C-r>"
" Run / execute the current file
nmap <Leader>e :!%:p<CR>

" copy all to clipboard
nmap <Leader>c ggVG"*y

" open markdown preview
nmap <Leader>p :Mm<CR>

" clear search buffer
map <Leader>/ :let @/ = ""<CR>

" run ctags. Check for local / project versions first.
nmap <Leader>cc :!(test -f ./ctags.sh && ./ctags.sh) \|\|  (test -f ./bin/ctags.sh && ./bin/ctags.sh) \|\| echo 'no ./ctags.sh or ./bin/ctags.sh found'<CR>

" allow for per-project configuration files (project .vimrc)
set exrc
" disable unsafe commands in your project-specific .vimrc files
set secure
hi! CursorLineNr cterm=bold
