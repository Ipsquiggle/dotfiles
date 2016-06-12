set nocompatible | filetype indent plugin on | syn on

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

" Sensible: Better defaults
VAMActivate sensible


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Generic VIM stuff I like
" No ding!!
set visualbell
" Nice font
set guifont=Consolas:h10
" Tab/indent settings
set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
" == UI stuff ==
" Hide that useless toolbar
set guioptions-=T
" Show partial command being typed
set showcmd
" Display line numbers
set number " shows the actual number of the current line
" Free up the menu shortcuts for binding
set winaltkeys=no
" Prevent the cursor from reaching the edge of the frame. Especially handy
" during incsearch
set scrolloff=4
" Highlight the cursor line
set cursorline
" don't refresh the screen until a macro is complete. (faster, less
" flickering)
set lazyredraw
" Break lines at words
set lbr
" This determines the initial window size.
" (Should see if there is some way to memorize this on close to open it that
" way next time.)
set lines=80 columns=120
" Code folding -- I disabled this coz folds just seem to annoy me..
set foldcolumn=0
" Save undo history to disk
set undofile
" Get rid of tilde files!!!
set undodir=C:\\temp\\undo
"set backupdir=C:\\temp\\tilde
"set directory=C:\\temp\\tilde
set directory=""
set noswapfile
set nobackup
set nowritebackup
" Autoindenting on
set autoindent
" Makes regexps and searches a little more friendly
set magic
set gdefault
" Case-insensitive searching, unless I want it magically
set ignorecase
set smartcase
" Will autosave the file when navigating around.. Doesn't trigger on
" bufferswitch so it's actually kind of useless. The autocmd is more relable
" it seems.
"set autowrite
set autowriteall
au FocusLost * :silent! wa
au BufLeave * :silent! update
" Visible whitespace
set listchars=tab:\|\ ,trail:~,extends:>,precedes:<
"set listchars=tab:»-,trail:~,extends:>,precedes:<
set list
" In general, serach up the whole tree for tags files
set tags=./tags,tags;/
" Highlight ocurrences of the word under the cursor
autocmd CursorMoved * exe printf('match Todo /\V\<%s\>/', escape(expand('<cword>'), '/\'))
" I like buffers in the background
set hidden
" Highlight search matches
set hlsearch

" == KEYBINDINGS ==
" Special keybindings
" F3: /clear search highlighting xyz<CR>
noremap <F3> :noh<CR>
" Run the makeprg the usual way
noremap <F5> :make<CR>
" Quick way to jump to the end of a line in insert mode
inoremap <C-]> <ESC>A
" J joins two lines, so K will split two lines.
nnoremap K i<CR><ESC>
" Quickly cycle through buffer list in normal mode
nnoremap <C-LEFT> :bp<CR>
nnoremap <C-RIGHT> :bn<CR>
" Remap the increment and decrement keys to account for the windows bindings.
nnoremap <M-a> <C-A>
nnoremap <M-x> <C-X>
" Shortcut to duplicate a line and increment it.
nnoremap <M-i> yyp<C-A>
" Open new line from insert mode
inoremap <S-CR> <ESC>o
" Some window manipulation shortcuts -- Commented out, using DWM plugin
" instead
"nmap <C-l> <C-w>l
"nmap <C-h> <C-w>h
"nmap <C-j> <C-w>j
"nmap <C-k> <C-w>k
" <c-w>_ expands the window FuLLY, this pulls it back a bit...
nmap <M-h> <C-w>_<C-w>6-







" Solarlized: Color scheme
VAMActivate Solarized
set background=light
colorscheme solarized

" Airline: Pretty status line! Whee!
VAMActivate vim-airline

" DWM: Better automatic split positioning/management
VAMActivate dwm

" UltiSnips: Snipped stuff
VAMActivate UltiSnips
VAMActivate vim-snippets

" Unite: useful fuzzy search for all kinds of things!
VAMActivate unite
" Unite-tag: a Tag source for Unite
VAMActivate github:tsukkee/unite-tag
" Neoinclude: required by unite-tag
VAMActivate github:Shougo/neoinclude.vim

" Easytags: Automatically regenerate tags files
VAMActivate easytags
let g:easytags_auto_highlight=0
set tags=./tags;
let g:easytags_dynamic_files=1

" Vimshell: required for easytags
VAMActivate vimshell

" Surround: shortcut for placing braces and brackets around things
VAMActivate surround

" Neocomplete: Provides a completion source from buffer keywords and tags
VAMActivate neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" Supertab: Easy tab completion of various things!
VAMActivate Supertab

" Clevertab: An alternate tab completion, I like it's promise but it doesn't
" seem to work right.
"VAMActivate github:neitanod/vim-clevertab
"call CleverTab#NeoCompleteFirst()

" TComment: toggle comments
VAMActivate tComment

" Unimpaired: Lots of handy shortcuts for common toggle tasks
VAMActivate unimpaired
" Unimpaired-style maps for quickfix list
nnoremap [c :colder<CR>
nnoremap ]c :cnewer<CR>

" Wipeout: Close hidden buffers
VAMActivate github:artnez/vim-wipeout

" Tabular: for lining up text e.g. around equals signs
VAMActivate Tabular



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILETYPE STUFF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LUA: this seems like a good lua plugin
VAMActivate lua%3625

