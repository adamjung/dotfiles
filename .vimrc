set nocompatible
filetype off

let use_you_complete_me = 0 " experiencing editor lag. try turning this off for now

" vim-plug  *****************************************************************
call plug#begin('~/.vim/plugged')
if use_you_complete_me
    Plug 'Valloric/YouCompleteMe'
endif
Plug 'benmills/vimux'
Plug 'bogado/file-line'
Plug 'dcosson/vimux-nose-test2'
Plug 'flowtype/vim-flow'
Plug 'jnwhiteh/vim-golang'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'juvenn/mustache.vim'
Plug 'kana/vim-fakeclip'
Plug 'mileszs/ack.vim'
Plug 'mxw/vim-jsx'
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
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
Plug 'w0rp/ale'
call plug#end()

filetype plugin indent on
syntax on

let &runtimepath.=',~/.vim/bundle/ale'
:runtime! ~/.vim/

" use either , or \ as <Leader>
let mapleader = ","
nmap \ ,

" Basics ********************************************************************
set backspace=indent,eol,start " fix backspace in vim 7
set cm=blowfish
set number
set et
set sw=4
set smarttab
set incsearch
set hlsearch
set ignorecase
set smartcase
set cursorline
set cursorcolumn
set title
set ruler
set showmode
set showcmd
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent    (local to buffer)

" airline *******************************************************************
set laststatus=2 " Show filename at bottom of buffer
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'wombat'

" ale ***********************************************************************
let g:ale_enabled = 1
nnoremap <leader>a :ALENextWrap<CR>

set statusline+=%#warningmsg#
set statusline+=%{ALEGetStatusLine()}
set statusline+=%*

let g:ale_lint_on_text_changed = 'normal'
let g:ale_fix_on_save = 1

let g:airline#extensions#ale#enable = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:airline_section_error = '%{ALEGetStatusLine()}'

let g:ale_linters = {
\  'javascript': ['eslint'],
\  'jsx': ['eslint'],
\  'ruby': ['ruby', 'rubocop'],
\}

let g:ale_fixers = {
\  'javascript': ['prettier', 'remove_trailing_lines'],
\  'ruby': ['rubocop', 'remove_trailing_lines'],
\}

let g:ale_javascript_prettier_options = ' --parser babylon --single-quote --jsx-bracket-same-line --trailing-comma es5 --print-width 100'
let g:ale_javascript_eslint_use_global = 1

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal g`\"" |
    \ endif

" Search ********************************************************************
set tags=./tags;
set grepprg=ag\ --vimgrep
set grepformat=%f:%l:%c:%m
let g:ackprg = 'ag --vimgrep'

" switch from horizontal to vertical split
command H2v normal <C-w>t<C-w>H
" switch from vertical to horizontal split
command V2h normal <C-w>t<C-w>K

" Completion ****************************************************************
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python setlocal list
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

let g:ctrlp_working_path_mode = 0
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
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal formatprg=prettier\ --write\ --single-quote\ --jsx-bracket-same-line\ --parser\ babylon\ --trailing-comma\ es5\ --print-width\ 100

let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" Python ********************************************************************

" prevent comments from going to beginning of line
autocmd BufRead *.py inoremap # X<c-h>#
" turn on python folding when you open a file
autocmd BufRead *.py set foldmethod=indent
autocmd BufRead *.py set foldlevel=1
" configure pydiction
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
noremap <Leader>d Oimport pdb; pdb.set_trace()<Esc>
au FileType python setlocal formatprg=autopep8\ -
au FileType python setlocal equalprg=autopep8\ -

" Ruby **********************************************************************
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype eruby setlocal ts=2 sts=2 sw=2

" Vimux  ********************************************************************
let g:vimux_ruby_file_relative_paths = 1
let g:vimux_nose_options="--nologcapture"

" vimux ruby
autocmd FileType ruby   map <Leader>rb :RunAllRubyTests<CR>
autocmd FileType ruby   map <Leader>rl :call VimuxRunCommand("clear; RSPEC_CLEAN_WITH_DELETION=1 RSPEC_TRUNCATE_AFTER_SUITE=1 RSPEC_SKIP_ELASTICSEARCH_SETUP=1 ./bin/rspec " . expand("%.") . ":" . line("."))<CR>
autocmd FileType python map <Leader>rb :call VimuxRunNoseFile()<CR>
autocmd FileType python map <Leader>rl :call VimuxRunNoseLine()<CR>
autocmd FileType javascript map <Leader>rb :call VimuxRunCommand("clear; xvfb-run ./node_modules/karma/bin/karma start --single-run=true --single-file=\"" . expand("%.") . "\"")<CR>
autocmd FileType javascript map <Leader>rl :call VimuxRunCommand("clear; ./dev-scripts/karma-start-single-run-line-number.sh " . expand("%.") . ":" . line("."))<CR>

" Theme *********************************************************************
set rtp+=/Users/adam/dotfiles/themes/tomorrow-theme/vim
colorscheme Tomorrow-Night

" Shortcuts *****************************************************************
imap <C-l> <C-r>"
" Run / execute the current file
nmap <Leader>e :!%:p<CR>

" copy all to clipboard
nmap <Leader>c ggVG"*y

" show keymappings in a searchable buffer
function! s:ShowMaps()
    let old_reg = getreg("a")          " save the current content of register a
    let old_reg_type = getregtype("a") " save the type of the register as well
    try
        redir @a                           " redirect output to register a
        " Get the list of all key mappings silently, satisfy "Press ENTER to continue"
        silent map | call feedkeys("\<CR>")    
        redir END                          " end output redirection
        vnew                               " new buffer in vertical window
        put a                              " put content of register
        " Sort on 4th character column which is the key(s)
        %!sort -k1.4,1.4
    finally                              " Execute even if exception is raised
        call setreg("a", old_reg, old_reg_type) " restore register a
    endtry
endfunction
com! ShowMaps call s:ShowMaps()      " Enable :ShowMaps to call the function
nmap <Leader>mm :ShowMaps<CR>
