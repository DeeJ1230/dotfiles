" Basic {{{
syntax on
filetype plugin indent on
set nocompatible
set number
set relativenumber
set nowrap
set showmode
set scrolloff=0
set colorcolumn=0
set smartcase
set smarttab
set smartindent
set autoindent
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=2
set incsearch
set hlsearch
set ignorecase
set mouse=a
set history=1000
" set clipboard=unnamedplus,autoselect
" set completeopt=menuone,menu,longest
set t_Co=256
set cmdheight=1
set encoding=utf-8
set fileencodings=utf-8
" set nospell
" set nobackup
" set noswapfile
set undofile
set undodir=~/.vim/undo
set hidden
set nocursorline
set laststatus=2
set backspace=indent,eol,start
set linespace=1
set showmatch
set foldmethod=marker
set foldenable
set foldlevelstart=10
set foldnestmax=10
set listchars=tab:•\ ,trail:•,extends:»,precedes:« 
set list
set showbreak=>>\ 
set lazyredraw
set splitright
set splitbelow
" set diffopt+=iwhite
if exists('g:loaded_fugitive')
  set statusline+=%{fugitive#statusline()}
endif
" if has('win32')
"   set wildignore+=*\\.stack-work\\*,*\\packages\\*,*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox,*.dll,*.exe,*\\obj\\*,*\\bin\\*,*.mdb,*.pdb
" else
set wildignore+=*/.stack-work/*
set wildignore+=*/packages/*
set wildignore+=*/tmp/*
set wildignore+=*/obj/*
set wildignore+=*/bin/*
set wildignore+=*/build/*
set wildignore+=*/elm-stuff/*
set wildignore+=*/.git/*
set wildignore+=*/.cabal-sandbox/*
set wildignore+=*.swp
set wildignore+=*.swo
set wildignore+=*.zip
set wildignore+=*.dll
set wildignore+=*.exe
set wildignore+=*.mdb
set wildignore+=*.pdb
set wildignore+=*.sigdata
set wildignore+=*.optdata
set wildignore+=*.gitattributes
set wildignore+=*.psmdcp
set wildignore+=*.srcsrv
set wildignore+=*.nupkg
set wildignore+=*.png
set wildignore+=*.jpg
set wildignore+=*.jpeg
set wildignore+=*.gif
set wildignore+=*.svg
" endif
set wildmode=longest,list,full
set wildmenu
set wildignorecase

augroup quickfix
  autocmd!
  autocmd FileType qf setlocal wrap
augroup END

autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
" }}}

" GUI {{{
if has( "gui_running" )
  set columns=153
  set lines=38
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set guifont=NotoSansMono\ Nerd\ Font\ Medium\ Condensed\ 14
  set background=dark
  colorscheme antares
  "set background=light
  "colorscheme aurora
  "set background=light
  "colorscheme habiLight

  set guicursor=n-v-c:block-Cursor-blinkon0
  set guicursor+=ve:ver35-Cursor
  set guicursor+=o:hor50-Cursor-blinkwait175-blinkoff150-blinkon175
  set guicursor+=i-ci:ver20-Cursor
  set guicursor+=r-cr:hor20-Cursor
  set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

  augroup maximizewindow
    autocmd!
    autocmd VimEnter * call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)
  augroup END
else
  set background=dark
  colorscheme default
  hi Search term=reverse ctermbg=1 ctermfg=15
  hi Visual term=reverse ctermbg=0
  hi Folded term=standout ctermbg=0 ctermfg=15
endif
" }}}

" Mapping {{{
let mapleader=","
map <space> <leader>
map <space><space> <leader><leader>
nnoremap <F7> :make<CR>
nnoremap <C-c> :cclose<CR>
nnoremap <space><space> :nohlsearch<CR>
nmap <leader>zz :let &scrolloff=999-&scrolloff<CR>
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-j> :bd<CR>
nmap <S-Tab> :NERDTreeToggle<CR>
nnoremap <leader>f :FZF!<CR>
"nnoremap <leader>f :CtrlP<CR>
"nnoremap <leader>b :CtrlPBuffer<CR>
"nnoremap <leader>/ "zyiw:vimgrep /<C-r>z/g **/*<CR>:cw<CR>
nnoremap <leader>/ "zyiw:vimgrep /<C-r>z/gj **/*.%:e<CR>:cw<CR>
nnoremap <leader>g "zyiw:vimgrep /<C-r>z\n*\s*::/gj **/*.%:e<CR>:cw<CR>
nnoremap <leader>q "zyiw:vimgrep /<C-r>z/gj **/*.%:e
nnoremap <leader>dd :diffthis<CR>
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>do :diffoff<CR>
nnoremap <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
" }}}

" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = ' '
let g:airline_powerline_fonts = 0
"let g:airline_theme = 'biogoo'
"let g:airline_theme = 'lucius'
let g:airline_theme = 'seagull'
"let g:airline_theme = 'silver'
"let g:airline_theme = 'sol'
" }}}

" FZF {{{

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

"" Customize fzf colors to match your color scheme
let g:fzf_colors = { 'fg': ['fg', 'Normal'], 'bg': ['bg', 'Normal'], 'hl': ['fg', 'Comment'], 'fg+': ['fg', 'Exception', 'CursorColumn', 'Normal'], 'bg+': ['bg', 'CursorLine', 'CursorColumn'], 'hl+': ['bg', 'Error'], 'info': ['fg', 'PreProc'], 'border': ['fg', 'Ignore'], 'prompt': ['fg', 'Conditional'], 'pointer': ['fg', 'Exception'], 'marker': ['fg', 'Keyword'], 'spinner': ['fg', 'Label'], 'header': ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" }}}

" CtrlP {{{
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_show_hidden = 1
let g:ctrlp_path_nolim = 1
let g:ctrlp_working_path_mode = ''
let g:ctrlp_custom_ignore = '\v[\/]dist$'
let g:ctrlp_custom_ignore = {
\   'dir': '\v[\/](dist|vendor|\.git)$'
\ }
" }}}

" Syntastic {{{
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_rst_checkers = ['rstcheck']
" }}}

" Haskell {{{
autocmd FileType haskell set makeprg=stack\ build\ --test
autocmd FileType haskell nnoremap <buffer> <F1> :HdevtoolsInfo<CR>
autocmd FileType haskell nnoremap <buffer> <S-F1> :HdevtoolsType<CR>
autocmd FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
autocmd FileType haskell nnoremap <buffer> <F5> :exec ":!hasktags -x -c ./**/*.hs"<CR><CR>
autocmd BufWritePost *.hs silent! :exec ":!hasktags -x -c ./**/*.hs"
autocmd FileType haskell nnoremap <buffer> <F9> :ALEFix<CR>
" autocmd FileType haskell map <silent> <leader>t :GhcModType<CR>
" autocmd FileType haskell map <silent> <leader>T :GhcModTypeInsert<CR>
" autocmd FileType haskell map <silent> <leader>c :GhcModTypeClear<CR>
" autocmd FileType haskell map <silent> <leader>i :GhcModInfo<CR>
" autocmd FileType haskell map <silent> <leader>I :GhcModInfoPreview<CR>
" autocmd FileType haskell map <silent> <leader>l :GhcModLint<CR>
" autocmd FileType haskell map <silent> <leader>e :GhcModExpand<CR>
" autocmd FileType haskell map <silent> <leader>s :GhcModSigCodegen<CR>
autocmd FileType haskell vmap a= :Tabularize /=<CR>
autocmd FileType haskell vmap a: :Tabularize /::<CR>
autocmd FileType haskell vmap a> :Tabularize /-><CR>
autocmd FileType haskell vmap a< :Tabularize /<-<CR>
autocmd FileType haskell vmap a- :Tabularize /--<CR>

autocmd FileType haskell setlocal keywordprg=hoogle
autocmd FileType haskell setlocal foldmethod=indent

"hi hsStructure gui=NONE guifg=yellow
"hi hsStatement gui=NONE guifg=yellow
"hi hsTypedef gui=NONE guifg=yellow
"hi hsConditional gui=NONE guifg=yellow
"hi hsInfix gui=NONE guifg=yellow
"hi hsType gui=NONE guifg=#008080
"hi hsOperator gui=NONE guifg=salmon
"hi ALEError ctermbg=none cterm=underline
"hi ALEWarning ctermbg=none cterm=underline

let g:syntastic_haskell_hdevtools_args  = '-g -Wall'
let g:ale_linters = {'haskell': ['hlint', 'hdevtools']}
let g:ale_fixers = {'haskell': ['brittany']}
let g:ale_haskell_hdevtools_options  = '-g -Wall'
let g:ale_completion_enabled = 1
" }}}

" Go {{{
" let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
" let g:go_term_enabled = 1
let g:go_highlight_build_constraints = 1
" let g:go_auto_type_info = 1
" let g:go_metalinter_autosave = 1
let g:go_metalinter_command = "gometalinter -e bindata -e vendor -e nix/store --enable-all ./..."
" let g:go_metalinter_autosave_enabled = [
"       \  'golint',
"       \  'gotype',
"       \  'vet',
"       \]

autocmd FileType go setlocal nolist

autocmd FileType go noremap <silent> <F2> :GoRename<CR>
autocmd FileType go noremap <silent> <F3> :GoAlternate<CR>
autocmd FileType go noremap <silent> <F4> :GoDecls<CR>
autocmd FileType go noremap <silent> <S-F4> :GoDeclsDir<CR>
autocmd FileType go noremap <silent> <F5> :GoRun<CR>
autocmd FileType go noremap <silent> <F7> :GoBuild<CR>:GoTestCompile<CR>
autocmd FileType go noremap <silent> <F8> :GoLint<CR>
autocmd FileType go noremap <silent> <S-F8> :GoVet<CR>
autocmd FileType go noremap <silent> <F9> :GoInfo<CR>
autocmd FileType go noremap <silent> <S-F9> :GoTestFunc<CR>
autocmd FileType go noremap <silent> <F10> :GoCoverage<CR>
autocmd FileType go noremap <silent> <S-F10> :GoCoverageToggle<CR>
autocmd FileType go noremap <silent> <F12> :GoDef<CR>
" }}}

" {{{ TaskList

map T :TaskList<CR>
map F :TlistToggle<CR>

" }}}

" {{{ Python

" enable all Python syntax highlighting features
let python_highlight_all = 1

" }}}

" Markdown {{{
au BufEnter *.md set tw=80
au BufEnter *.md set filetype=markdown
au BufEnter *.md set syntax=markdown
au BufRead *.md setlocal spell
" }}}

" Xml {{{
" recognize Xml format
au BufEnter *.xml set filetype=xml
au BufEnter *.xml set syntax=xml
au BufReadPre *.xml setlocal foldmethod=indent
" }}}

" Elm {{{
let g:elm_jump_to_error = 0
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_browser_command = ""
let g:elm_detailed_complete = 0
let g:elm_format_autosave = 0
let g:elm_format_fail_silently = 0
let g:elm_setup_keybindings = 1
" }}}

" F# {{{
let g:syntastic_fsharp_checkers=['syntax']
let g:fsharp_only_check_errors_on_write = 0
let g:fsharp_completion_helptext = 1
let g:fsharp_map_keys = 1
" let g:fsharp_map_prefix = 'cp'
let g:fsharp_map_gotodecl = 'g'
let g:fsharp_map_gobackfromdecl = 'b'
au BufCreate,BufEnter *.fsproj set filetype=xml
au BufCreate,BufEnter *.csproj set filetype=xml
" }}}

" Rst {{{
au BufCreate,BufEnter *.rst set filetype=rst
au BufCreate,BufEnter *.rst set tw=80
" }}}

" Goyo {{{
function! s:goyo_enter()
  set scrolloff=999
  Limelight0.8
endfunction

function! s:goyo_leave()
  set scrolloff=0
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <leader>- :Goyo 90<CR>
nnoremap <leader>= :Goyo!<CR>
" }}}

" NERDTree {{{
let g:NERDTreeWinPos = 'left'
let g:NERDTreeWinSize = 40
let g:NERDTreeDirArrows = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\.swp$', '^bin$', '^obj$', '^dist$']
" let g:NERDTreeHighlightCursorline = 1
" let g:NERDTreeCaseSensitiveSort = 1
" let g:NERDTreeMinimalUI = 1
" let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeQuitOnOpen = 1
" let g:NERDTreeShowBookmarks = 1
" let NERDTreeHijackNetrw = 1
let g:NERDChristmasTree = 1
" }}}

" SuperTab {{{
let g:SuperTabDefaultCompletionType = "context"
" }}}

" TaskWarrior {{{
" " default task report type
" let g:task_report_name     = 'next'
" " custom reports have to be listed explicitly to make them available
" let g:task_report_command  = []
" " whether the field under the cursor is highlighted
" let g:task_highlight_field = 1
" " can not make change to task data when set to 1
" let g:task_readonly        = 0
" " vim built-in term for task undo in gvim
" let g:task_gui_term        = 1
" " allows user to override task configurations. Seperated by space. Defaults to ''
" let g:task_rc_override     = 'rc.defaultwidth=999'
" " default fields to ask when adding a new task
" let g:task_default_prompt  = ['due', 'description']
" " whether the info window is splited vertically
" let g:task_info_vsplit     = 0
" " info window size
" let g:task_info_size       = 15
" " info window position
" let g:task_info_position   = 'belowright'
" " directory to store log files defaults to taskwarrior data.location
" let g:task_log_directory   = '~/.task'
" " max number of historical entries
" let g:task_log_max         = '20'
" " forward arrow shown on statusline
" let g:task_left_arrow      = ' <<'
" " backward arrow ...
" let g:task_left_arrow      = '>> '
" }}}

set textwidth=0
