" VIM-POLYGLOT
" Need to load before vim-polyglot is loaded
let g:polyglot_disabled = ['autoindent', 'sensible']

"Specify a directory for plugins
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim'
Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
Plug 'tomtom/tcomment_vim'
Plug 'mbbill/undotree'
Plug 'ap/vim-css-color',
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'ludovicchabant/vim-gutentags'
Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'joshdick/onedark.vim'
Plug '1995eaton/vim-better-javascript-completion'
Plug 'takac/vim-hardtime'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'pacha/vem-tabline'

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
highlight Pmenu ctermbg=235
highlight TabLineSel ctermbg=237 ctermfg=252
highlight TabLine ctermfg=247

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
nnoremap <M-j> <C-W><C-J>
nnoremap <M-k> <C-W><C-K>
nnoremap <M-l> <C-W><C-L>
nnoremap <M-h> <C-W><C-H>

" Clear last search pattern
:command Clear let @/=""

" Omni completion
set completeopt+=longest,menuone,noinsert
set omnifunc=syntaxcomplete#Complete
imap <M-space> <c-x><c-o>

" List chars
set listchars=eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

" Switching buffers shortcut
nnoremap ,b :ls<cr>:b<space>
map <Right> :bnext<CR>
map <Left> :bprevious<CR>

" Auto save files when vim losts focus and switching buffers
function AutoSave()
    if @% != ""
        " No filename for current buffer
        update
    endif
endfunction

au FocusLost * call AutoSave()
au BufLeave * call AutoSave()

" No auto cd to files directory
set noautochdir

" Terminal shortcut
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

" If open fzf windows inside terminal windows, this will auto remap <Esc>
autocmd! BufLeave * if count('terminal',&buftype)
  \ | tnoremap <Esc> <C-\><C-n>
  \ | endif

" Status line
let g:currentmode={
	\ 'n'  : 'NORMAL',
	\ 'v'  : 'VISUAL',
	\ 'V'  : 'V·LINE',
	\ '' : 'V·BLOCK',
	\ 's'  : 'SELECT',
	\ 'S'  : 'S·LINE',
	\ '' : 'S·BLOCK',
	\ 'i'  : 'INSERT',
	\ 'R'  : 'REPLACE',
	\ 'c'  : 'COMMAND',
	\}

highlight leftSection ctermbg=237 ctermfg=254
highlight rightSection ctermbg=237 ctermfg=252 cterm=NONE
highlight subsection ctermbg=236 ctermfg=247
highlight subsectionInactive ctermbg=236 ctermfg=242
highlight middle ctermbg=NONE
highlight middleInactive ctermbg=NONE ctermfg=242

function! ActiveStatusLine()
  highlight leftSection cterm=bold
  setlocal laststatus=2
  setlocal statusline=
  setlocal statusline+=%#leftSection#
  setlocal statusline+=\ %{g:currentmode[mode()]}
  setlocal statusline+=\ %#subsection#
  setlocal statusline+=\ %{Signify()}
  setlocal statusline+=\ %{FugitiveHead()}
  setlocal statusline+=\ %#middle#
  setlocal statusline+=\ %f
  setlocal statusline+=\ %m
  setlocal statusline+=\ %h
  setlocal statusline+=\ %w
  setlocal statusline+=%<
  setlocal statusline+=\ %{CocNvimDiagnostic()}
  setlocal statusline+=%=
  setlocal statusline+=%{gutentags#statusline()}
  setlocal statusline+=\ %#rightSection#
  setlocal statusline+=\ %p%%
  setlocal statusline+=\ ☰
  setlocal statusline+=\ %l/%L\ 
  setlocal statusline+=\:\ %c\ 
endfunction

function! InactiveStatusLine()
  setlocal laststatus=2
  setlocal statusline=
  setlocal statusline+=%#subsectionInactive#
  setlocal statusline+=\ %{Signify()}
  setlocal statusline+=\ %{FugitiveHead()}
  setlocal statusline+=\ %#middleInactive#
  setlocal statusline+=%<
  setlocal statusline+=\ %F
  setlocal statusline+=\ %m
endfunction

function! TerminalStatusLine()
  setlocal laststatus=2
  setlocal statusline=
  setlocal statusline+=%#leftSection#
  setlocal statusline+=\ %{toupper(mode())}
  setlocal statusline+=\ %#subsection#
  setlocal statusline+=\ %{strpart(expand('%f'),16,23)}
  setlocal statusline+=\ %#middle#
  tnoremap <Esc> <C-\><C-n>
endfunction

augroup statusline
  autocmd!

  " Statusline for specific windows
  autocmd FileType netrw setlocal statusline=%#leftSection#\ Netrw\ %#middle# | hi leftSection cterm=NONE
  autocmd FileType startify setlocal statusline=%#leftSection#\ Startify\ %#middle# | hi leftSection cterm=NONE
  autocmd FileType undotree setlocal statusline=%!t:undotree.GetStatusLine()
  autocmd TermOpen * call TerminalStatusLine()

  " Active, Inactive statusline for vim windows
  autocmd BufEnter,WinEnter * if !count(['netrw','startify','undotree'],&filetype) && !count('terminal',&buftype)
    \ | call ActiveStatusLine()
    \ | endif
  autocmd BufLeave,WinLeave * if !count(['netrw','startify','undotree'],&filetype) && !count('terminal',&buftype)
    \ | call InactiveStatusLine()
    \ | endif

  " Active, Inactive statusline for netrw window
  autocmd WinLeave * if count('netrw',&filetype)
    \ | setlocal statusline=%#subsectionInactive#\ Netrw\ %#middle#
    \ | endif
  autocmd WinEnter * if count('netrw',&filetype)
    \ | setlocal statusline=%#leftSection#\ Netrw\ %#middle#
    \ | endif

" Active, Inactive statusline for startify window
  autocmd WinLeave * if count('startify',&filetype)
    \ | setlocal statusline=%#subsectionInactive#\ Startify\ %#middle#
    \ | endif
  autocmd WinEnter * if count('startify',&filetype)
    \ | setlocal statusline=%#leftSection#\ Startify\ %#middle#
    \ | endif

  " Change mode section color when enter insert mode
  " autocmd InsertEnter * highlight leftSection ctermbg=241 ctermfg=254
  " autocmd InsertLeave * highlight leftSection ctermbg=237 ctermfg=254
augroup END

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



"	COC.NVIM CONFIGURATIONS

let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-css', 'coc-emmet', 'coc-tsserver', 'coc-snippets', 'coc-prettier']

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Add status line support, for integration with other plugin, checkout `:h coc-status`
function! CocNvimDiagnostic() abort
	  let info = get(b:, 'coc_diagnostic_info', {})
	  if empty(info) | return '' | endif
	  let msgs = []
	  if get(info, 'error', 0)
	    call add(msgs, 'E' . info['error'])
	  endif
	  if get(info, 'warning', 0)
	    call add(msgs, 'W' . info['warning'])
	  endif
	  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
	endfunction

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
nmap <silent> <M-s> <Plug>(coc-range-select)
xmap <silent> <M-s> <Plug>(coc-range-select)

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

" VIM-SIGNIFY
  \ 'colorscheme': 'onedark',
  \ } VIM-SIGNIFY
function! s:sy_stats_wrapper()
      let [added, modified, removed] = sy#repo#get_stats()
      let symbols = ['+', '~', '-']
      let stats = [added, modified, removed]  " reorder
      let statline = ''

      for i in range(3)
        if stats[i] > 0
          let statline .= printf('%s%s ', symbols[i], stats[i])
        endif
      endfor

      if !empty(statline)
        let statline = printf('%s', statline[:-2])
      endif

      return statline
    endfunction

function! Signify()
      return s:sy_stats_wrapper()
    endfunction

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
" Opening Diff panel in neovim will causes errors
let g:undotree_DiffAutoOpen = 0
nnoremap <F3> :UndotreeToggle<CR>

" INDENTLINE
let g:indentLine_char = '⎸'
let g:indentLine_fileTypeExclude = ['startify']
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'

" VIM-BETTER-OMNICOMPLETE-JS-COMPLETION
let g:vimjs#casesensistive = 0
let g:vimjs#smartcomplete = 1
let g:vimjs#chromeapis = 1

" VIM-HARDTIME
let g:hardtime_default_on = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+"]
let g:list_of_disabled_keys = ["<UP>", "<DOWN>"]
let g:list_of_insert_keys = ["<LEFT>", "<RIGHT>"]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1

" FZF.VIM
" Remap <Esc> back to default to easily exit fzf window by <Esc>
autocmd FileType fzf setlocal noruler | tnoremap <Esc> <Esc>
let g:fzf_nvim_statusline = 0

" VEM-TABLINE
let g:vem_tabline_show_number='buffnr'
let g:vem_tabline_number_symbol='⏐'
let g:vem_tabline_right_arrow=''
let g:vem_tabline_left_arrow=''

