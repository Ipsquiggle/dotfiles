set nocompatible | filetype indent plugin on | syn on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
		\		shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sensible: Better defaults
VAMActivate sensible


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Move whole lines up and down "
nnoremap <M-j> mz:m+<CR>`z==
nnoremap <M-k> mz:m-2<CR>`z==
inoremap <M-j> <Esc>:m+<CR>==gi
inoremap <M-k> <Esc>:m-2<CR>==gi
vnoremap <M-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z







"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Solarlized: Color scheme
VAMActivate Solarized
set background=light
colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline: Pretty status line! Whee!
VAMActivate vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
"let g:airline_powerline_fonts = 1
"let g:airline_theme="dark"
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space=' '
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
	if g:airline_theme == 'dark'
		" airline_c is the 'middle' part of the airline, where the filename appears
		let a:palette.inactive.airline_c[0] = "#DDDDDD"
		let a:palette.inactive_modified.airline_c[0] = "#BB88FF"
	endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DWM: Better automatic split positioning/management
VAMActivate dwm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips: Snipped stuff
VAMActivate UltiSnips
VAMActivate vim-snippets

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unite: useful fuzzy search for all kinds of things!
VAMActivate unite
let g:unite_source_grep_command = 'C:\Dropbox\bin\ag.exe'
let g:unite_source_grep_default_opts = 
		  \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
		  \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file,file/new,buffer,file_rec,line,neomru,tags', 'matchers', 'matcher_fuzzy')

" Unite Tag: a Tag source for Unite
VAMActivate github:tsukkee/unite-tag
" Neoinclude: required by unite-tag
VAMActivate github:Shougo/neoinclude.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easytags: Automatically regenerate tags files
VAMActivate easytags
set tags=./tags,tags;/
let g:easytags_auto_highlight=0
let g:easytags_dynamic_files=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimshell: required for easytags
VAMActivate vimshell

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Surround: shortcut for placing braces and brackets around things
VAMActivate surround

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neocomplete: Provides a completion source from buffer keywords and tags
VAMActivate neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
let g:neocomplete#ctags_command = 'C:\Dropbox\bin\ctags.exe'

" Plugin key-mappings.
inoremap <expr><C-g>	 neocomplete#undo_completion()
inoremap <expr><C-l>	 neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Supertab: Easy tab completion of various things!
VAMActivate Supertab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clevertab: An alternate tab completion, I like it's promise but it doesn't
" seem to work right.
"VAMActivate github:neitanod/vim-clevertab
"call CleverTab#NeoCompleteFirst()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TComment: toggle comments
VAMActivate tComment

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Unimpaired: Lots of handy shortcuts for common toggle tasks
VAMActivate unimpaired
" Unimpaired-style maps for quickfix list
nnoremap [c :colder<CR>
nnoremap ]c :cnewer<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Wipeout: Close hidden buffers
VAMActivate github:artnez/vim-wipeout

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular: for lining up text e.g. around equals signs
VAMActivate Tabular

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AG: because good grepping is good
VAMActivate ag
let g:ag_highlight=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyMotion: seems fun...
VAMActivate EasyMotion
" default is \\s YIKES!
nmap s <Plug>(easymotion-s2)
vmap s <Plug>(easymotion-s2)
omap s <Plug>(easymotion-s2)
" see which one I like more...
nmap ff <Plug>(easymotion-s)
vmap ff <Plug>(easymotion-s)
omap ff <Plug>(easymotion-s)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Local Vimrc: Easy vim-style customization per project/folder
VAMActivate localvimrc
" If we answer with an uppercase letter, save between sessions
let g:localvimrc_persistent = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TODO:
" Signify: Git/SVN hunk signs. Do I want this?
" let g:signify_vcs_list = ['git', 'svn']
" let g:signify_difftool = 'diff'
" Linediff: This one is really cool, though I don't use it much...
" NEOMru: MRU addon for Unite
" Rainbow Parenthesis: There's a new one by luochen
" Showmarks: Show the marks as signs. I use this.... sometimes.
" Syntastic: Run linters automatically. Except I think this is what makes my
" lua so slow.
" Tagbar: I'm hoping that this will be obsoleted by Unite!
" nnoremap <F8> :TagbarToggle<CR>
" Unite Outline: What did this one do?
" Vim Bbye: Yeah, I use this one a lot!
" Vim Expand Region: I've only used this one a few times but it seems super
" handy! But seems like surround, bracket motions, etc. covers it...
" Vim Indent Guides: Not sure this one worked, but I like the idea...
" Vim Notes: This almost seems really good! Except I use evernote...
" Vim Repeat: Apparently I need this...?
" Vim Speeddating: I think I used this once...
" Vim Vinegar: I really want to use this but it seems to mess up a lot!
" Yankring: Yes, it's very handy!
" Delimitmate: I like it, but breaking . ticks me off... But maybe it's Repeat
" breaking it?
" Vim Multiple Cursors: REALLLLY want this to work...
" Ags Vim: ags-vim seems like a great idea, but it never seems to work...

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Tortoise commands. Note: This requires my localvimrc to work correctly
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command Tblame !start tortoiseproc /command:blame /path:%
command Tlogall exec "!start tortoiseproc /command:log /path:".b:basepath
command Tlog !start tortoiseproc /command:log /path:%
command Tcommitall exec "!start tortoiseproc /command:commit /path:".b:basepath
command Tcommit !start tortoiseproc /command:commit /path:%
command Tclean exec "!start tortoiseproc /command:clean /path:".b:basepath
command Tupdateall exec "!start tortoiseproc /command:update /path:".b:basepath
command Tupdate !start tortoiseproc /command:update /path:%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILETYPE STUFF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LUA: this seems like a good lua plugin
" VAMActivate lua%3625
autocmd Filetype lua set noexpandtab
