" VIM-POLYGLOT
" Need to load before vim-polyglot is loaded
let g:polyglot_disabled = ['autoindent', 'sensible']

"Specify a directory for plugins
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
Plug 'tomtom/tcomment_vim'
Plug 'mbbill/undotree'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-css-color',
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'ludovicchabant/vim-gutentags'
Plug 'sheerun/vim-polyglot'
Plug 'prettier/vim-prettier'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug '907th/vim-auto-save'

" Initialize plugin system
call plug#end()

" VIM AND NVIM CONFIGURATIONS

"Indent with spaces
set softtabstop=2 shiftwidth=2 expandtab

set smartindent

"Sign Collumn on the left
set signcolumn=yes

"Demonstrate line numbers on the left
set number relativenumber 

"Open files in Chrome
nnoremap <F12>c :exe ' !open -a /Applications/Google\ Chrome.app %'<CR>

"Open files in Safari 
nnoremap <F12>s :exe ' !open -a /Applications/Safari.app %'<CR>

"Disable bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"Enable vim fuzzy search
"Search all subdirectories and recursively
set path+=**          

set wildmode=longest,full
set wildignorecase

"Open quickfix window automatically when grep
autocmd QuickFixCmdPost *grep* cwindow

" Use case insensitive search, except when using capital letters
set ignorecase smartcase 

"Access system clipboard
set clipboard^=unnamed,unnamedplus

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

" Instead of failing a command because of unsaved changes, instead raise a dialogue asking if you wish to save changed files.
set confirm

" Alow moving cursor to places where theres no text in visual block mode
set virtualedit=block

" Prevent updating screen while executing macros, registers and other commands that have not been typed
set lazyredraw

" Time to trigger CursorHold event in ms
set updatetime=1000

"Theme
colorscheme onedark
highlight Normal ctermbg=black

"Mapping <Leader>] for html to css tags jumping
nnoremap <leader>] :tag /<c-r>=expand('<cword>')<cr><cr>

" No generate backup files and swap files
set nobackup nowritebackup noswapfile

" Use ripgrep instead
if executable('rg')
	set grepprg=rg\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Open new split panes to right, which feels more natural
set splitright

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Clear last search pattern
:command Clear let @/=""

" Omni completion
set completeopt+=longest,menuone,noinsert
set omnifunc=syntaxcomplete#Complete
imap <c-space> <c-x><c-o>

" List chars
set listchars=eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨



"	COC.NVIM CONFIGURATIONS

let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-css', 'coc-emmet', 'coc-tsserver', 'coc-snippets', 'coc-prettier']

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Jump to next placeholder by <Tab>
let g:coc_snippet_next = '<tab>'

" Setup Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Remap for format selected region (using Prettier)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)



" VIM PLUGINS' CONFIGURATIONS

" PERSISTENT UNDO
" Guard for distributions lacking the persistent_undo feature.
if has('persistent_undo')
  " define a path to store persistent_undo files.
  let target_path = expand('~/.config/persisted-undo/')

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

" VIM-STARTIFY
let g:startify_lists = [
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'files',     'header': ['   MRU']            },
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ ]

"Vim-startify commands
let g:startify_commands = [
  \ ['Show netrw', ':Lex'],
  \ ['Open Fuzzy Finder', ':FZF'],
  \ ]

"Vim-startify bookmarks
let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'}, {'z': '~/.zshrc'},]

"Save/Load sessions
let g:startify_session_dir = '~/.config/sessions'

"Auto save session when leaving vim and before loading a new session via :SLoad 
let g:startify_session_persistence = 0

" When opening a file or bookmark, change to its directory
let g:startify_change_to_dir = 1

" filter recently used files
let g:startify_skiplist = [ '.vimrc', '.zshrc', 'coc-settings.json']

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

" Vim Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
set noshowmode

" RAINBOW
let g:rainbow_active = 1
let g:rainbow_conf = {
\ 'ctermfgs': ['208', '171', '220', '204'],
\ 'separately': {
\   'html': 0,
\   'css': 0,
\ }
\}

" UNDOTREE
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HighlightChangedText = 1
let g:undotree_HighlightChangedWithSign = 1

" INDENTLINE
let g:indentLine_char = '⎸'
let g:indentLine_fileTypeExclude = ['startify']
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'

" VIM-AUTO-SAVE
let g:auto_save = 1
let g:auto_save_silent = 1

