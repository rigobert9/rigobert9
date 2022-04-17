" rigobert9's .vimrc
" This vimrc was mostly inspired and stolen from vim-IDE on github, so a lot of
" this configuration comes from his too. Please pay him a visit for something
" more functionnal.
" Have any issues ? Please open a pull request or send me a mail at
" francois.gallois.pro at gmail.com
" You can also correct it to your liking or document it : any modification can
" be interesting for me, don't be shy !

" -----------------------------
"			Classic parameters

" Auto-update for Plug and installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" No vi compatibility
set nocompatible
" You can change this to your liking if you don't plan on using a theme, but be
" aware some terms make the arrows print letters in insert mode instead of
" moving. This parameter allows to have a common basis.
set term=xterm-256color

" Classic leader key
let mapleader = ","

let current_compiler = "gcc"
set encoding=UTF-8
set ai
set nu
set tw=80
" Less go for 2-spaces indentations, Prettier can take care of the rest
set ts=2
set shiftwidth=2
" You can wrap with all commands
set whichwrap+=<,>,h,l,[,]

" Managing vim swaps, to keep work safe and without bloating the system
" MAKE SURE TO CREATE DIRECTORIES AS VIM WON'T DO IT ITSELF
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
" PAY ATTENTION WHE EDITING SENSITIVE INFORMATION ! SOME CONFIDENTIAL INFO
" COULD BE BACKED UP FOR ALL TO SEE
" In case of bother with these files that are useless most of the time, you
" can just take them off instead :
" set noswapfile

set autochdir
set backspace=indent,eol,start

filetype plugin indent on
syntax on

" Vim default syntax checking activation.
" If a plugin has his proper syntax checkers, the default will be overwritten
" because misc is the first inserted.
set omnifunc=syntaxcomplete#Complete
filetype plugin indent on

" Highlights the searched word
set hlsearch

" Activating spell checking
" To make this feature available, you need to find your dictionnaries
" These lists of words are often found in /usr/share/dict
" To use them, you need to generate a binary file for vim : create a .vim/spell 
" directory, then run :
" :mksp ~/.vim/spell/[language identifier, like "en"] [path to the dictionnary]
setlocal spell spelllang=en
" You can begin to use it with the commands in ":h spell"

" If you want to unload buffers when you abandon them instead of keep them open,
" you can uncomment this line.
" Your system will use less memory and files, but some plugins like dotoo prefer
" staying open.
set hidden

" -----------------------------
"  		Plugins

call plug#begin('~/.vim/bundle')

" -----------------------------
"  		Navigating and writing feel

" auto-pairs : closes parentheses and brackets automatically
Plug 'jiangmiao/auto-pairs'

" We need autocompletion. Quite a lot. But Vim already gives it to us.
" Vicompletesme just makes it a bit easier, while not using a language server
" hogging your ram.
Plug 'ackyshake/VimCompletesMe'
" Now your just need to press tab, no need to think about it !

" vim-bufkill : allow you to delete a buffer, without destroying the split it
" lives in. Gets you out of complicated solutions or the frustration to redo the
" window.
Plug 'qpkorr/vim-bufkill'

" nerd-commenter gives easy comment/uncomment utilities
Plug 'preservim/nerdcommenter'

" vim-surround adds operations on matching partentheses, tags, brackets ...
Plug 'tpope/vim-surround'
" Way more advanced features can be attained with the plugin
" Matt-A-Bennett/vim-surround-funk; please check it out if you're interested in
" gripping whole function calls.

" Quite the complicated plugin, please read the manual or the README of the
" repo. If you don't like this solution to aligning, two different plugins are
" suggested in the README of this project
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" You can zoom temporarily on a single window, by using "ctrl-w m" on it.
Plug 'dhruvasagar/vim-zoom'

" -----------------------------
"  		Project management and IDE

" WE DON'T NEED NERDTREE. This config uses Netrw, the built-in file explorer of
" Vim. If you don't like it, you can always take those plugins here and change
" the ctrl-g binding at the end of the file.
" nerdtree:
" 	The NERD tree allows you to explore your filesystem and to open files
" 	and directories. It presents the filesystem to you in a tree  form tree
" 	which you manipulate with the keyboard and/or mouse (if set mouse=a
" 	activated). It also allows you to perform simple filesystem operations.
" Plug 'scrooloose/nerdtree'

" vim-nerdtree-tabs
" This plugin aims at making NERDTree feel like a true panel, independent of
" tabs.
" Plug 'jistr/vim-nerdtree-tabs'

" This tab is started up automatically if you opened a directory
" let g:nerdtree_tabs_open_on_console_startup=2
" You can uncomment this if you don't want the tabs to sync between instances
" let g:nerdtree_tabs_synchronize_view=0

" A plugin for git, adds a status icon for files in a git repo
" It needs to be plugged last.
" Plug 'Xuyuanp/nerdtree-git-plugin'

" Netrw : the built-in file explorer.
let g:netrw_keepdir = 0 " Some fixes
let g:netrw_liststyle = 3 " By default a tree view
let g:netrw_winsize = 15 " A smaller split
let g:netrw_banner = 0 " Stop showing the banner every time
let g:netrw_localcopydircmd = 'cp -r' " Lets you copy directories by default
let g:netrw_browse_split = 4 " Opens the file in the last window
let g:netrw_altv = 1
" Uncomment this if you want your marked files to be highlighted like search results
" hi! link netrwMarkFile Search

" fugitive : git wrapper, to help you while using git.
Plug 'tpope/vim-fugitive'

" vim-gitgutter : a git-diff-like viewer that allows you to modify and view what
" you changed. The plugin is quite complex, please refer to the repository page
" on github !
Plug 'airblade/vim-gitgutter'
" Updating a lot more to show the diffs more often. It will also save the swap
" files more often.
set updatetime=100

" ctrl-p : By pressing <ctrl-p> (duh), you can search up for files, buffers, and
" so on
Plug 'ctrlpvim/ctrlp.vim'
" This plugin is quite extensible, as mentionned on the repo (try the github
" research). Those are the ones I chose.
" Adds research for the commandline history, the yank history, and the ctrlp
" modes themselves
Plug 'sgur/ctrlp-extensions.vim'
" Opens all the extensions
let g:ctrlp_extensions = ['menu', 'line', 'dir', 'yankring', 'mixed', 'tag',
												\ 'buffertag', 'cmdline', 'undo', 'changes',
												\ 'quickfix', 'rtscript', 'bookmarkdir']
let g:ctrlp_regexp = 1 "Search by regexp by default
" There's A LOT of extensions to this plugin. Here's a list of all the fun you
" can add (names are all repositories on github) :
" - lucidstack/ctrlp-mpc.vim to manage you songs on mpc
" - a lot of plugins to switch between tabs
" - d11wtq/ctrpl_delete.vim to delete open buffers
" - mattn/ctrp-register to check registers
" - FriedSock/ctrlpsimilar to navigate in projects
" - codewithkristian/ctrlp-branches to navigate between git branches
" - mattn/ctrlp-hackernews to browse HN and search it
" - zeero/vim-ctrlp-help for vim help finding
" - zhaohuaxishi/ctrlp-header for standard header in C/C++
" - mattn/ctrlp-google to search on google
" - mattn/ctrlp-mcdonald to get a snacc, IDK
" - MeanEYE/ctrlp-leader-guide to browse your <leader> keybindings
" - tsuyoshicho/vim-pass to manage passwords with pass

" We're managing tags (functions across the project) with universal-ctags
" Gutentags : manages the refreshing of our tags and generates the tags files
Plug 'ludovicchabant/vim-gutentags'
" and adding a bit more to it
Plug 'skywind3000/gutentags_plus'

" THESE PLUGINS NEED YOU TO CREATE A .vim/sessions/ DIRECTORY
" Sessions are one damn useful feature : you can save multiple layouts and open
" files for your different projects.
" This first approach is simpler and leaner, but you can choose the second plugin
" instead if you want something easier.
" These commands just open the command to type, and you complete them.
" See them at http://www.bit-101.com/techtips/2018/03/31/Vim-sessions/
nnoremap <Leader>ss :mksession! ~/.vim/sessions/
" Saves to session
nnoremap <Leader>os :source ~/.vim/sessions/
" Opens a session
nnoremap <Leader>rs :!rm ~/.vim/sessions/
" Removes a session
" I might add the possibility to save a variable for theses three commands later

" There's still another way to do it, check out
" https://www.abdus.net/blog/2020/session-management-in-vim/#importance-of-session
" Plug 'xolox/vim-session'
" Yet another plugin by Tim Pope, that auto-saves most modifications to your
" session, creates a default Session.vim session if you create an anonyous section
" and adds the :Obsess command to start recording changes to a session (stop with
" :Obsess!)
Plug 'tpope/vim-obsession'

" -----------------------------
"  		Visual cues

" Colors parentheses, brackets and identation blocks (in html for example),
" making it easier to read the code, esapecially in LISP
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" Show the marks you placed on your code to help navigation
Plug 'jeetsukumaran/vim-markology'

" Show syntax errors when you write to a file, but needs to charge some synatx
" checkers.
Plug 'vim-syntastic/syntastic'
" If your language is not supported by the plugins here, just search for
" language plugins : they often include a syntax checker
" We will add syntax checkers in the languages section

" Recommended defaults
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Changes numbers when in normal mode to show relative numbers, and absolute in
" insert mode.
Plug 'myusuf3/numbers.vim'
" Press F3 to change the numbers mode
nnoremap <silent> <F3> :NumbersToggle<CR>
" Default settings, but you can add filetypes if numbers are shown or shown
" strangely in some files
let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'netrw']

" vim-better-whitespaces highlights useless whitespaces and provides the function
" :StripWhiteSpace to get rid of extra whitespace.
Plug 'ntpeters/vim-better-whitespace'

" -----------------------------
"  		Language-specific plugins

" vim-pdf : Read pdf files with vim. Needs the xpdf utility to be installed, as
" it uses the pdftotext command.
Plug 'makerj/vim-pdf'

" This command, found at https://vim.fandom.com/wiki/Improved_hex_editing, allow
" you to toggle a binary to a hex dump that you can edit.
"
" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" Vim-markdown : allows to use links between markdown files, so you can use
" knowledge bases like the ones created by Obsidian
Plug 'preservim/vim-markdown'

" If you want to use vim as your manpager, which you can do by setting
" "export MANPAGE="vim -" in your bashrc, this plugin makes it easier and leaner
Plug 'muru/vim-manpager'

" -----------------------------
"  		Eyecandy

" A clock for Vim, that changes colors according to the time of the day
Plug 'mopp/sky-color-clock.vim'
let g:sky_color_clock#datetime_format='%H:%M'
" You can modify this format easily. Just know that the year (with only the last
" two digits) is %y.
" let g:sky_color_clock#datetime_format='%H:%M %d/%m' (with day and month)
" Beware that the status line is updated only when you enter keystrokes, so the
" clock won't be on time if you don't move.

" Statusline
" To do : display current mode in the bar
set laststatus=2
set statusline=
" Always display the status line
" Add a few things to the status line : you can have a lot of fun with this
" part, like showing the price of ETH or he weather if you want to.
" https://shapeshed.com/vim-statuslines/
set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{FugitiveHead()}
" Uses fugitive to get the git status
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
set statusline+=%{IsReadonly()}
set statusline+=\ %{SyntasticStatuslineFlag()}
set statusline+=\ %{ObsessionStatus()}
set statusline+=%=
set statusline+=%{zoom#statusline()}
set statusline+=\ %#warningmsg#
set statusline+=\ %#CursorColumn#
set statusline+=\ %y
set statusline+=%{CanEncoding()}
set statusline+=%{CanFileformat()}
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=%#SkyColorClock#%{sky_color_clock#statusline()}

function! IsReadonly()
  return &readonly && &filetype !=# 'help' ? ' |RO|' : ''
endfunction
" Those trim some information on smaller windows
function! CanFileformat()
	return winwidth(0) > 80 ? '[' . &fileformat . ']' : ''
endfunction
function! CanEncoding()
  return winwidth(0) > 70 ? (&fileencoding?&fileencoding:&encoding) : ''
endfunction

" Hightlight the yanked text, because why not
Plug 'machakann/vim-highlightedyank'

"  This plugin needs to be plugged last, there's a risk of collision
"  otherwise

" A plugin to get nice icons for each file type
" It needs nerd-fonts
" Plug 'ryanoasis/vim-devicons'

call plug#end()

" -----------------------------
"  		Special keybindings

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Opens the Netrw panel
noremap <C-g> :Lexplore<CR>
" Opens in directory of the current file
nnoremap <leader>dd :Lexplore %:p:h<CR>
" Opens the NERDTree panel
" noremap <C-g> :NERDTreeTabsToggle<CR>

" Adds some bindings to the netrw window

" Adds a function to remove a non-empty directory
function! NetrwRemoveRecursive()
  if &filetype ==# 'netrw'
    cnoremap <buffer> <CR> rm -r<CR>
    normal mu
    normal mf

    try
      normal mx
    catch
      echo "Canceled"
    endtry

    cunmap <buffer> <CR>
  endif
endfunction

function! NetrwMapping()
  nmap <buffer> H u
  nmap <buffer> h -^
  nmap <buffer> l <CR>

  nmap <buffer> . gh
  nmap <buffer> P <C-w>z

  nmap <buffer> L <CR>:Lexplore<CR>
  nmap <buffer> <Leader>dd :Lexplore<CR>
	nmap <buffer> <TAB> mf
	nmap <buffer> <S-TAB> mF
	nmap <buffer> <Leader><TAB> mu

	nmap <buffer> ff %:w<CR>:buffer #<CR>
	nmap <buffer> fe R
	nmap <buffer> fc mc
	nmap <buffer> fC mtmc
	nmap <buffer> fx mm
	nmap <buffer> fX mtmm
	nmap <buffer> f; mx

	nmap <buffer> bb mb
	nmap <buffer> bd mB
	nmap <buffer> bl gb

	nmap <buffer> FF :call NetrwRemoveRecursive()<CR>
endfunction
" H "goes back"" in history
" h "goes up" a directory
" l opens a directory or file
" . toggles the dotfiles
" P closes the preview window
" L opens a file and closes netrw
" <leader>dd closes netrw
" <tab> toggles the marks
" <shift><tab> unmarks all files in the buffer
" <leader><tab> removes all marks
" ff creates a files, and in contrast to %, saves it immediately
" fe renames a file
" fc copies the marked files
" fC copies the marked file to the directory you're hovering on
" fx moves the marked files
" fX does the same as fC but for moving
" f; runs an external command on the marked files
" bb creates a bookmark
" bd removes to the most recent bookmark
" bl jumps to the most recent bookmark
" FF calls the function and removes a non-empty directory
" Everything here comes from
" https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/,
" please go pay the article a visit !

" Let's pack all of these
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
	" Doesn't use Markology in netrw tabs
  autocmd FileType netrw :MarkologyDisable
augroup END

" Vim's meant to be used with buffers and you might take a liking to it
" These keybindings will just make it all smoother
function! SwitchToNextBuffer(incr)
  let help_buffer = (&filetype == 'help')
  let current = bufnr("%")
  let last = bufnr("$")
  let new = current + a:incr
  while 1
    if new != 0 && bufexists(new) && ((getbufvar(new, "&filetype") == 'help') == help_buffer)
      execute ":buffer ".new
      break
    else
      let new = new + a:incr
      if new < 1
        let new = last
      elseif new > last
        let new = 1
      endif
      if new == current
        break
      endif
    endif
  endwhile
endfunction
" Enter and Shift-Tab cycle through the buffers; each in a different direction
nnoremap <CR> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
" Shift-Left and Shift-Right cycle through ALL buffers; each in a different direction
nnoremap <silent> <S-Left> :call SwitchToNextBuffer(1)<CR>
nnoremap <silent> <S-Right> :call SwitchToNextBuffer(-1)<CR>

" -----------------------------
"  		Some more configuration, on a per-language basis

" For bash files
autocmd BufNewFile,BufRead *.sh set textwidth=0
autocmd BufNewFile,BufRead *.sh set wrapmargin=0
autocmd BufNewFile,BufRead *.sh set cc=0
autocmd BufNewFile,BufRead *.sh set expandtab
autocmd BufNewFile,BufRead *.sh set ts=2
autocmd BufNewFile,BufRead *.sh set shiftwidth=2

" For Java
autocmd FileType java set expandtab

" For MarkDown
autocmd BufNewFile,BufRead *.md set wrapmargin=0
autocmd BufNewFile,BufRead *.md set cc=0

" For OCaml
autocmd BufNewFile,BufRead *.md set wrapmargin=0

" For Python, runs the file when F5 is pressed
nnoremap <silent> <F5> :!clear;python %<CR>
au Filetype py setl et ts=4 sw=4

" Wrapping isn't used by a lot of web developers, so it's unset
autocmd BufNewFile,BufRead *.html,*.css,*.php,*.js,*.less,*.scss,*.json,*.xml  set textwidth=0
autocmd BufNewFile,BufRead *.html,*.css,*.php,*.js,*.less,*.scss,*.json,*.xml  set wrapmargin=0
autocmd BufNewFile,BufRead *.html,*.css,*.php,*.js,*.less,*.scss,*.json,*.xml  set cc=0
autocmd BufNewFile,BufRead *.html,*.css,*.php,*.js,*.less,*.scss,*.json,*.xml  set expandtab
autocmd BufNewFile,BufRead *.html,*.css,*.php,*.js,*.less,*.scss,*.json,*.xml  set ts=2
autocmd BufNewFile,BufRead *.html,*.css,*.php,*.js,*.less,*.scss,*.json,*.xml  set shiftwidth=2

" For YAML
autocmd BufNewFile,BufRead *.yml  set ts=2
autocmd BufNewFile,BufRead *.yml  set shiftwidth=2

" vim -b : edit binary using xxd-format!
" Opens binary fileswith the xxd util
" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif
" This very advanced version can be found on https://vim.fandom.com/wiki/Improved_hex_editing
" These two commands can be used as well to launch a new vim made for editing
" binaries :
" Launch in tabs in a new dedicated Vim hex editor:
" 	vim -p -b -c "set binary" --servername HEXVIM <files>
" Launch in tabs in an existing dedicated Vim hex editor:
" 	vim -b -c "set binary" --servername HEXVIM --remote-tab-silent <files>

" There are still incredible plugins and features out there : this footer contains some
" you light want to check out :
" - https://github.com/dhruvasagar/vim-table-mode, Vim as a spreadsheet
" - https://github.com/dhruvasagar/vim-audiobox, Vim to control rythmbox
" - https://github.com/dhruvasagar/vim-github-review, a hard-to-setup plugin to manage github
"	PRs in Vim
" - https://github.com/dhruvasagar/vim-marp, Vim for presentations inspired by marp
" - https://github.com/itchyny/screensaver.vim, a screensaver for Vim
" - https://github.com/dhruvasagar/vim-dotoo, an emacs-org-mode inspired agenda, todo
" 	and notes plugin
" - https://github.com/lucidstack/ctrp-tmux.vim, to switch between tmux session from ctrl-p
" - https://github.com/JazzCore/ctrlp-cmatcher, to get a blazing fast search in ctrl-p with python
" 	and C
" - https://github.com/christoomey/vim-system-copy, for further problems with the system clipboard
" - https://github.com/preservim/vimux, for more interactions with termux
" - https://github.com/matze/vim-move, if you like the idea of moving more visually you text blocks
" - https://github.com/Shougo/echodoc.vim, displays function information in the echo line
" - https://github.com/lambdalisue/vim-gista, to browse gistson github (there's
"   also a ctrlp extension)
