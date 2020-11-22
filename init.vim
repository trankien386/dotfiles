"Specify a directory for plugins
call plug#begin()

"Comment stuffs
Plug 'tomtom/tcomment_vim'

"Undo history visualizer
Plug 'mbbill/undotree'

"Auto save
Plug '907th/vim-auto-save'

"Css color preview
Plug 'ap/vim-css-color'

"Git plugin
Plug 'tpope/vim-fugitive'

"Git changes status in sign column
Plug 'airblade/vim-gitgutter'

"Auto generate ctags
Plug 'ludovicchabant/vim-gutentags'

"Format code
Plug 'prettier/vim-prettier'

"Start screen for vim
Plug 'mhinz/vim-startify'

"Quoting/Parenthesizing
Plug 'tpope/vim-surround'

"VSCode intellisense
Plug 'neoclide/coc.nvim'

"Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Syntax Highlighting
Plug 'sheerun/vim-polyglot'

"Icon for Plugins ALWAYS AT LAST
Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

" VIM CONFIGURATIONS

set nocompatible

"Indent with spaces
set softtabstop=2 "number of spaces per TAB
set shiftwidth=2 "same value as softtabstop
set expandtab "press TAB will output spaces instead

"Automactically indent lines
set autoindent
set smartindent

"Sign Collumn on the left
set signcolumn=yes

"Demonstrate line numbers on the left
set number 

"File type detection
filetype plugin indent on

"Open files in Chrome
nnoremap <F12>c :exe ' !open -a /Applications/Google\ Chrome.app %'<CR>

"Open files in Safari 
nnoremap <F12>s :exe ' !open -a /Applications/Safari.app %'<CR>

"Disable bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" noremap h <NOP>
noremap j <NOP>
noremap k <NOP>
" noremap l <NOP>
noremap - <NOP>
noremap + <NOP>

"Enable vim fuzzy search
set nocompatible      "Limit search to your project
set path+=**          "Search all subdirectories and recursively
set wildmenu          "Shows multiple matches on one line
set wildignorecase

"Open quickfix window automatically when grep
autocmd QuickFixCmdPost *grep* cwindow

"Show commands are typed
set showcmd

"Mute error sound
set belloff=all

"Move the cursor to the matched string, while typing the search pattern
set incsearch

"Highlight all search matches
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

"Access system clipboard
set clipboard=unnamed

"Paste texts from other windows to terminal VIM correctly
set pastetoggle=<F2>

"No line wrap
set nowrap

"netrw list style
let g:netrw_liststyle = 3

"netrw - open files in new vertical split window
let g:netrw_browse_split = 4

"netrw - hide files
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"disable top banner
let g:netrw_banner=0

"Open splits to the right
let g:netrw_altv=1

"Add fzf to vim
set rtp+=/usr/local/share/fzf

"Switch buffers without saving changes
set hidden

" Stop certain movements from always going to the first character of a line.
set nostartofline

" Instead of failing a command because of unsaved changes, instead raise a dialogue asking if you wish to save changed files.
set confirm

" Alow moving cursor to places where theres no text in visual block mode
set virtualedit=block

" Prevent updating screen while executing macros, registers and other commands that have not been typed
set lazyredraw

" Read :h ttyfast
set ttyfast

" Time to trigger CursorHold event in ms
set updatetime=1000

"Theme
syntax on
colorscheme onedark
highlight Normal ctermbg=black

"Mapping <Leader>] for html to css tags jumping
nnoremap <leader>] :tag /<c-r>=expand('<cword>')<cr><cr>

" No generate backup files and swap files
set nobackup
set nowritebackup
set noswapfile

"Reduce delay time for modes indicator in status line to change
set ttimeoutlen=10

" Use ripgrep instead
if executable('rg')
	set grepprg=rg\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif



" "	COC.NVIM CONFIGURATIONS

" " Use `[g` and `]g` to navigate diagnostics
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)
"
" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')
" set background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=darkset background=dark"
" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)
"
" " Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
"
" augroup mygroup
" autocmd!
" " Setup formatexpr specified filetype(s).
" autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" " Update signature help on jump placeholder
" autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
"
" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)
"
" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)
"
" " Create mappings for function text object, requires document symbols feature of languageserver.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)
"
" " Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)
"
" " Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')
"
" " Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
" " use `:OR` for organize import of current buffer
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
" " Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
" "<cr> for confirm completion
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
" "TAB for trigger completion, completion confirm, snippet expand and jump like VSCode
" inoremap <silent><expr> <TAB>
" \ pumvisible() ? coc#_select_confirm() :
" \ <SID>check_back_space() ? "\<TAB>" :
" \ coc#refresh()
"
" function! s:check_back_space() abort
" let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" let g:coc_snippet_next = '<tab>'
"
" "Show documentation of symbol when doing cursor hover
" nnoremap <silent> K :call CocActionAsync('doHover')<cr>



" VIM PLUGINS' CONFIGURATIONS

" PERSISTENT UNDO
" Guard for distributions lacking the persistent_undo feature.
if has('persistent_undo')
    " define a path to store persistent_undo files.
    let target_path = expand('~/.vim/persisted-undo/')
    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call system('mkdir -p ' . target_path)
    endif
    " point Vim to the defined undo directory.
    let &undodir = target_path
    " finally, enable undo persistence.
    set undofile
endif

" UNDOTREE
" Undotree window layout
if !exists('g:undotree_WindowLayout')
    let g:undotree_WindowLayout = 2
endif

" Let undotree window get focus after being opened
if !exists('g:undotree_SetFocusWhenToggle')
    let g:undotree_SetFocusWhenToggle = 1
endif

" VIM-STARTIFY
" Returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

"Vim-startify commands
let g:startify_commands = [
        \ ['Show netrw', ':Lex'],
	\ ['Open Fuzzy Finder', ':FZF'],
        \ ]

"Vim-startify bookmarks
let g:startify_bookmarks = [ {'c': '~/.vimrc'},]

"Save/Load sessions
let g:startify_session_dir = '~/.vim/sessions'

"Auto save session when :SClose
let g:startify_session_persistence = 0

" VIM-GUTENTAGS
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']

" One true tags directory
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')

" Auto generate tags file
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" Include more info for tags
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]

" VIM-GITGUTER
" GitGutter fold all unchanged lines
set foldtext=gitgutter#fold#foldtext()

" Show added, modified, and removed lines in current buffer in status line
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

" Vim Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
set noshowmode

" VIM-AUTO-SAVE
let g:auto_save = 1
let g:auto_save_no_updatetime = 1
let g:auto_save_silent = 1

" VIM-POLYGLOT
let g:polyglot_disabled = ['autoindent', 'sensible']

" RAINBOW
let g:rainbow_active = 1
let g:rainbow_conf = {
\ 'ctermfgs': ['208', '198', '39', '34'],
\ 'separately': {
\   'html': 0,
\ }
\}


