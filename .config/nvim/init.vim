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
" Plug 'pacha/vem-tabline'
Plug 'voldikss/vim-floaterm'
Plug 'lervag/vimtex'
Plug 'rakr/vim-one'

" Initialize plugin system
call plug#end()



""	VIM AND NVIM CONFIGURATIONS

" INDENT WITH SPACES
set softtabstop=2 shiftwidth=2 expandtab 

" OPEN FILES IN CHROME
nnoremap <F12>c :exe ' !open -a /Applications/Google\ Chrome.app %'<CR>

" OPEN FILES IN SAFARI
nnoremap <F12>s :exe ' !open -a /Applications/Safari.app %'<CR>

" ENABLE VIM FUZZY SEARCH
" SEARCH ALL SUBDIRECTORIES AND RECURSIVELY
set path+=**          

" AUTO COMPLETION OPTIONS
set wildmode=longest,full
set wildignorecase

" OPEN QUICKFIX WINDOW AUTOMATICALLY WHEN GREP
autocmd QuickFixCmdPost *grep* cwindow

" USE CASE INSENSITIVE SEARCH, EXCEPT WHEN USING CAPITAL LETTERS
set ignorecase smartcase 

" ACCESS SYSTEM CLIPBOARD
set clipboard^=unnamed,unnamedplus

" PASTE TEXTS FROM OTHER WINDOWS TO TERMINAL VIM CORRECTLY
set pastetoggle=<F2> 

" NO LINE WRAP
set nowrap

" NETRW LIST STYLE
let g:netrw_liststyle = 3

" NETRW - OPEN FILES IN NEW VERTICAL SPLIT WINDOW
let g:netrw_browse_split = 4

" OPEN SPLITS TO THE RIGHT
let g:netrw_altv=1

" ADD FZF TO VIM
set rtp+=/usr/local/opt/fzf

" SWITCH BUFFERS WITHOUT SAVING CHANGES
set hidden

" INSTEAD OF FAILING A COMMAND BECAUSE OF UNSAVED CHANGES, INSTEAD RAISE A DIALOGUE ASKING IF YOU WISH TO SAVE CHANGED FILES.
set confirm

" ALOW MOVING CURSOR TO PLACES WHERE THERES NO TEXT IN VISUAL BLOCK MODE
set virtualedit=block

" PREVENT UPDATING SCREEN WHILE EXECUTING MACROS, REGISTERS AND OTHER COMMANDS THAT HAVE NOT BEEN TYPED
set lazyredraw

" TIME TO TRIGGER CURSORHOLD EVENT IN MS
set updatetime=1000

" MAPPING <LEADER>] FOR HTML TO CSS TAGS JUMPING
nnoremap <leader>] :tag /<c-r>=expand('<cword>')<cr><cr>

" NO BACKUP FILES AND SWAP FILES
set nobackup nowritebackup noswapfile

" USE RIPGREP INSTEAD OF GREP
if executable('rg')
      set grepprg=rg\ --vimgrep
      set grepformat=%f:%l:%c:%m
endif

" OPEN NEW SPLIT PANES TO RIGHT
set splitright

" CLEAR LAST SEARCH PATTERN
:command Clear let @/=""

" OMNI COMPLETION
set completeopt+=longest,menuone,noinsert
set omnifunc=syntaxcomplete#Complete
imap <M-space> <c-x><c-o>

" SWITCHING BUFFERS SHORTCUT
nnoremap ,b :ls<cr>:b<space>

" AUTO SAVE FILES WHEN VIM LOSTS FOCUS AND SWITCHING BUFFERS
function AutoSave()
    if @% != ""
        " No filename for current buffer
        update
    endif
endfunction

au FocusLost * if !count('netrw',&filetype) && !count('terminal',&buftype)
	\ | call AutoSave()
	\ | endif
au BufLeave * if !count('netrw',&filetype) && !count('terminal',&buftype)
	\ | call AutoSave()
	\ | endif

" PERSISTENT UNDO
" Guard for distributions lacking the persistent_undo feature.
if has('persistent_undo')
  " define a path to store persistent_undo files.
  let target_path = expand('~/.cache/undodir')

  " create the directory and any parent directories if the location does not exist.
  if !isdirectory(target_path)
    call system('mkdir -p ' . target_path)
  endif

  " point Vim to the defined undo directory.
  let &undodir = target_path

  " finally, enable undo persistence.
  set undofile
endif



""	STATUS LINE
function! ActiveStatusLine()
  setlocal laststatus=1
  setlocal statusline=\ %F
  setlocal statusline+=\ %m
  setlocal statusline+=\ %h
  setlocal statusline+=\ %w
  setlocal statusline+=%<
  setlocal statusline+=%=
  setlocal statusline+=\ %l\ 
  setlocal statusline+=\:\ %c\ 
endfunction

function! InactiveStatusLine()
  setlocal statusline=%<
  setlocal statusline+=\ %F
  setlocal statusline+=\ %m
endfunction

" STATUSLINE FOR SPECIFIC WINDOWS
autocmd FileType netrw setlocal statusline=%f
autocmd TerminalOpen * setlocal statusline=%f
autocmd FileType undotree setlocal statusline=%!t:undotree.GetStatusLine()
autocmd FileType diff setlocal statusline=difference

" ACTIVE, INACTIVE STATUSLINE FOR WINDOWS
autocmd BufEnter,WinEnter * if !count(['netrw','undotree','diff'],&filetype) && !count('terminal',&buftype)
  \ | call ActiveStatusLine()
  \ | endif

autocmd BufLeave,WinLeave * if !count(['netrw','undotree','diff'],&filetype) && !count('terminal',&buftype)
  \ | call InactiveStatusLine()
  \ | endif



""	THEME
colorscheme onedark

" TRANSPARENT BACKGROUND FOR VSCODE'S TERMINAL
if ($TERM_PROGRAM == 'vscode')
  highlight Normal ctermbg=NONE
endif

" Omni completion's popup color
highlight Pmenu ctermbg=235



"	COC.NVIM CONFIGURATIONS

let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-css', 'coc-emmet', 'coc-tsserver', 'coc-snippets', 'coc-prettier', 'coc-tabnine', 'coc-floaterm', 'coc-vimtex', 'coc-texlab']

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
  \ ['Netrw', ':Lex'],
  \ ['Fuzzy Finder', ':FZF'],
  \ ['Terminal', ':FloatermToggle'],
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
" Ctags file location
let g:gutentags_cache_dir ='~/.cache'

" Include more info for tags
let g:gutentags_ctags_extra_args = [
  \ '--tag-relative=yes',
  \ '--fields=+aimnS',
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
nnoremap <F6> :UndotreeToggle<CR>

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

" FZF
" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ {'bg' : ['bg', 'Normal'],
            \ 'fg+' : ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'hl+' : ['fg', 'Statement'],
            \ 'info': ['fg', 'PreProc']}

" VEM-TABLINE
" let g:vem_tabline_show_number='buffnr'
" let g:vem_tabline_number_symbol='⏐'
" let g:vem_tabline_right_arrow=''
" let g:vem_tabline_left_arrow=''

" VIM-FLOATERM
let g:floaterm_keymap_toggle = '<F3>'
let g:floaterm_keymap_next   = '<F4>'
let g:floaterm_keymap_new    = '<F5>'

" VIM-FUGITIVE
" Toggle Gblame
function! s:ToggleBlame()
    if bufwinnr('fugitiveblame') == 1
      Gblame
      close
    else
      Gblame
      execute "normal \<C-W>\<C-L>"
    endif
endfunction

nnoremap <silent> <F2> :call <SID>ToggleBlame()<CR>