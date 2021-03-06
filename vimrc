" This must be first, because it changes other options as a side effect.
set nocompatible

let $DYLD_INSERT_LIBRARIES=''

set runtimepath=~/.dotfiles/vim,$VIMRUNTIME,~/.homebrew/share/vim,~/.dotfiles/vim/after

" Vundle initialization {{{
  filetype off
  " runtime! bundle/vim-pathogen/autoload/pathogen.vim
  if !filereadable(expand('~/.vim/bundle/vundle/README.md'))
    silent !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  endif

  set rtp+=~/.vim/bundle/vundle
  call vundle#rc()

  Plugin 'gmarik/vundle'
  Plugin 'tpope/vim-jdaddy'
  Plugin 'tpope/vim-capslock'
  Plugin 'tpope/vim-fugitive'
  Plugin 'tpope/vim-git'
  Plugin 'tpope/vim-endwise'
  Plugin 'tpope/vim-haml'
  Plugin 'tpope/vim-markdown'
  Plugin 'tpope/vim-rails'
  Plugin 'tpope/vim-rake'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-unimpaired'
  Plugin 'tpope/vim-abolish'
  Plugin 'tpope/vim-repeat'
  Plugin 'tpope/vim-bundler'
  Plugin 'tpope/vim-commentary'
  Plugin 'tpope/vim-eunuch'
  Plugin 'tpope/vim-scriptease'
  Plugin 'tpope/vim-dispatch'
  Plugin 'tpope/vim-projectionist'
  Plugin 'tpope/vim-obsession'
  Plugin 'cehoffman/vim-ragtag'
  Plugin 'cehoffman/csv.vim'
  Plugin 'cehoffman/vim-lua'
  Plugin 'scrooloose/syntastic'
  Plugin 'mileszs/ack.vim'
  Plugin 'kchmck/vim-coffee-script'
  Plugin 'vim-ruby/vim-ruby'
  Plugin 'ecomba/vim-ruby-refactoring'

  " Plugin 'pangloss/vim-javascript'
  Plugin 'claco/jasmine.vim'
  Plugin 'othree/yajs.vim'
  Plugin 'othree/es.next.syntax.vim'
  " Plugin 'gavocanov/vim-js-indent'
  Plugin 'jason0x43/vim-js-indent'

  Plugin 'lambdatoast/elm.vim'
  " Plugin 'isRuslan/vim-es6'
  Plugin 'MarcWeber/vim-addon-local-vimrc'

  Plugin 'Raimondi/delimitMate'
  Plugin 'tmatilai/gitolite.vim'
  Plugin 'othree/html5.vim'
  Plugin 'SirVer/UltiSnips'
  Plugin 'honza/vim-snippets'
  " Plugin 'Lokaltog/vim-easymotion'
  Plugin 'godlygeek/tabular'
  Plugin 'majutsushi/tagbar'
  Plugin 'kana/vim-textobj-user'
  Plugin 'nelstrom/vim-textobj-rubyblock'
  Plugin 'gregsexton/gitv'
  Plugin 'jamessan/vim-gnupg'
  Plugin 'vim-scripts/scratch.vim'
  Plugin 'sjl/splice.vim'
  Plugin 'b4winckler/vim-objc'
  Plugin 'AndrewRadev/splitjoin.vim'
  Plugin 'kien/ctrlp.vim'
  Plugin 'suy/vim-ctrlp-commandline'
  Plugin 'LaTeX-Box-Team/LaTeX-Box'
  Plugin 'vim-scripts/Match-Bracket-for-Objective-C'
  Plugin 'cehoffman/vim-bitbake'
  Plugin 'joonty/vdebug'
  Plugin 'mbbill/undotree'
  Plugin 'groenewege/vim-less'
  Plugin 'ledger/vim-ledger'
  Plugin 'ZoomWin'
  Plugin 'sjl/vitality.vim'
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'tmux-plugins/vim-tmux'
  Plugin 'tmux-plugins/vim-tmux-focus-events'
  Plugin 'christoomey/vim-tmux-navigator'
  Plugin 'elzr/vim-json'
  Plugin 'wellle/targets.vim'
  Plugin 'fatih/vim-go'
  Plugin 'jaxbot/github-issues.vim'
  Plugin 'ekalinin/Dockerfile.vim'
  Plugin 'moll/vim-node'
  Plugin 'leafo/moonscript-vim'
  Plugin 'rstacruz/sparkup'
  " Plugin 'clausreinke/typescript-tools.vim'
  " Plugin 'leafgarland/typescript-vim'
  Plugin 'rizzatti/dash.vim'
  Plugin 'ConradIrwin/vim-bracketed-paste'
  Plugin 'keith/swift.vim'
" }}}

" General settings {{{
  set timeout
  set ttimeout
  set timeoutlen=300
  set title
  set writeany             " Try and write without requiring !
  set history=1000         " keep 1000 lines of command line history
  set showcmd              " display incomplete commands
  set incsearch            " do incremental searching
  set virtualedit=block    " allows editing inside of characters that may not actually exist
  set noshowmode           " The much improved statusline makes it trivial to know your mode
  set scrolljump=10        " make the window jump 10 lines when reaching an edge, helpful to prevent slow scrolling
  set scrolloff=10         " Don't put the cursor so close to a windows edge
  set sidescrolloff=7      " sides can be a little more forgiving
  set sidescroll=1         " mode the side by 1
  set visualbell t_vb=     " disable the stupid bell
  set cmdheight=1          " Reduce the number of times the hit enter dialog comes up
  set shortmess+=aIWsc     " Make messages even shorter
  set laststatus=2         " Always display the status line
  set autoindent           " always set auto indenting on
  set smartindent          " automatically adjust the level of indentation with language constructs
  set tabstop=2            " how many spaces to use for a tab
  set softtabstop=2        " number of spaces a tab counts for
  set shiftwidth=2         " how much to shift text when using << or >>
  set expandtab            " expand tabs into spaces
  set shiftround           " when at an odd number of spaces and using >>/<< go to correct multiple
  set smarttab             " Insert the shiftwidth number of space at start of non empty line when using <Tab>
  set numberwidth=3        " and always show room for 2 numbers since it is only relative numbers
  set ignorecase           " don't use case when searching
  set smartcase            " unless I type an uppercase letter, then care
  set hidden               " Make Vim more accepting of hidden buffer
  set confirm              " Ask me what to do when quiting or saving fails
  set autoread             " Automatically reload files that change on disk
  set showmatch            " Jump to matching }] briefly when typing
  set matchtime=3          " Tenths of a second to show matching paren
  " set splitbelow           " Where to make splits by default
  " set splitright           " Where to make splits by default
  set fillchars=diff:\     " Don't put annoying - in deleted diff lines
  set nostartofline        " Don't jump to start of line as side effect, e.g. <<
  set updatetime=1500      " Make man auto command macros fire quicker, more often
  set pumheight=10         " control how many options are shown before scrolling on auto completion
  set mouse=a              " Turn on mouse support
  set ttymouse=sgr         " Support ultra wide terminals (> 223 columns)
  set nojoinspaces         " Don't add extra space when using SHIFT-J
  set display+=lastline    " Show the whole of a last line when it is wrapped
  set cpoptions+=yd        " allow yank commands to be repeated with '.'
  set cinoptions=:0,l1,g0,t0,(0,Ws
  set gdefault             " make substitutions default to replacing all on line
  set pastetoggle=<F2>     " Paste mode to turn off autoindention
  set fileformats=unix,dos " Make the default fileformat be unix line endings
  set encoding=utf-8       " Make default text encoding utf-8
  set termencoding=utf-8   " Make default termainl encoding utf-8
  set cryptmethod=blowfish " use a strong encryption method instead of weak one
  " set number               " Use number for now because relative is slow
  set relativenumber       " Make line numbers relative to my cursor for easy jumping
  set lazyredraw           " don't redraw the screen during macros
  set cursorline           " start with cursor shown
  set clipboard=unnamed,unnamedplus " make copying put on the system clipboard and pasting get from it

  if has("persistent_undo")
    set undofile
    set undodir=~/.dotfiles/vim/undo,tmp
  endif
  set backupdir=~/.dotfiles/vim/backup
  set backup
  set backupcopy=yes
  set noswapfile

  if has("spell")
    set spellfile=~/.dotfiles/vim/spell/common.utf-8.add  " store common correct/incorrect works in a shared place
  endif

  " Set command completion options to open a selectable menu
  set wildmenu
  set wildmode=longest:full,full
  set wildignore=*.o,*.rbc,*.obj,*.pyc,.git,CVS,.svn,tags,.hg
  set wildignorecase

  " Tab completion options
  " (only complete to the longest unambiguous match, and show a menu)
  set completeopt=longest,menuone,preview
  set complete=.,t,i,b,w

  set backspace=indent,eol,start " allow backspacing over everything in insert mode
  set formatoptions=cq1nrj
  set colorcolumn=+1       " Always be aware of the best file width
  set textwidth=79
  set wrap linebreak showbreak=\ …\  cpoptions+=n " Use soft wrapping, and adjust mappings for edit keys
  set list listchars=tab:▸\ ,eol:¬,precedes:<,extends:>,nbsp:· " Display extra whitespace

  " Enable file type detection.
  filetype plugin indent on

  " Only enable syntax once to prevent losing styles
  if !exists("syntax_on")
    syntax enable
  endif
" }}}

if !exists('g:loaded_matchit')
  runtime! macros/matchit.vim " Include the matchit macro
endif

let mapleader = "," " \ is the default leader character
let maplocalleader = ',' " \ is the default

" General Mappings {{{
  " Allows moving up by screen lines, not file lines
  map j gj
  map k gk

  " Don't use Ex mode, use Q for formatting
  map Q gq

  " Make Y consistent with C and D
  nnoremap Y y$

  " Keep searches in middle of screen
  nnoremap * *zzzv
  nnoremap # #zzzv
  nnoremap n nzzzv
  nnoremap N Nzzzv

  " Shortcut to redraw screen
  nnoremap <silent> <Leader><C-l> :redraw!<CR>
  vnoremap <silent> <Leader><C-l> :redraw!<CR>

  " Don't move the cursosr after pasting
  " noremap p p`[
  " noremap P P`[

  " Open an edit path relative to current file
  nnoremap <Leader>el :e <C-r>=expand('%:p:h')<CR>/

  " Select just pasted text in last used visual mode
  nnoremap <expr> <Leader>v '`[' . visualmode() . '`]'

  " Shortcut to edit .vimrc
  noremap <Leader>ev :edit ~/.dotfiles/vimrc<CR>

  " Simplistic buffer removal but keeping window
  nnoremap <silent> <Leader>bd :bp<BAR>bd #<CR>
  nnoremap <silent> <Leader>bw :bp<BAR>bw #<CR>

  " Paste without losing the item being pasted
  " vnoremap P p :call setreg(&clipboard =~# 'unnamed' ? '*' : '"', getreg('0')) <CR>

  " Screw the manual searching on shift K
  nnoremap K <nop>

  " Better movement in command line
  cnoremap <C-A> <Home>
  cnoremap <C-E> <End>

  " Make it easy to select the whole buffer
  vnoremap ae ggVoG$

  " Easy abbreviation to get path to current file mine file
  cabbrev %% <C-R>=expand('%:p:h')<CR>

  " Easy jump between last file
  nnoremap <Leader><Leader> <C-^>

  " When killing the current line, make it start a new undo at that point
  inoremap <C-U> <C-G>u<C-U>
" }}}

" Terminal/GUI Setup {{{
  set background=dark
  if !has("gui_running")
    " Workaround for making things like arrow keys work under screen
    if $TERM == 'screen*'
      set term=xterm
    elseif $TERM == 'screen-256color'
      set term=xterm-256color
    end

    " Color scheme
    let g:solarized_underline = 0
    if &t_Co > 255
      " colorscheme solarized
      colorscheme plasticcodewrap
    else
      colorscheme solarized
      colorscheme ir_black
    endif
  endif
" }}}

" Tabline {{{
  " set up tab labels with tab number, buffer name, number of windows
  function! TabLabel()
    let label = ''
    let i = 1
    let current = tabpagenr()

    while i <= tabpagenr('$')
      let bufnrlist = tabpagebuflist(i)

      " Let vim know which tab this delineates
      let label .= '%#TabLine# '
      let label .= '%' . (i == current ? '#TabLineSel#' : '#TabLine#') . '%' . i . 'T'

      " Append the tab number
      let label .= i . ': '

      " Append the buffer name
      let name = bufname(bufnrlist[tabpagewinnr(i) - 1])
      if name == ''
        " give a name to no-name documents
        if &buftype=='quickfix'
          let name = '[Quickfix List]'
        else
          let name = '[No Name]'
        endif
      else
        " get only the file name
        let name = fnamemodify(name,":p:t")
      endif
      let label .= name . ' '

      " Add '+' if one of the buffers in the tab page is modified
      for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
          let label .= '[+]'
          break
        endif
      endfor

      " Append the number of windows in the tab page
      let label .= '[' . tabpagewinnr(i, '$') . ']' . (i == current ? '' : '')
      let i += 1
    endwhile

    let label .= '%T%#TabLineFill#%=%999%X'
    return label
  endfunction

  set tabline=%!TabLabel()
" }}}

if has("autocmd")
  augroup GeneralSettings " {{{
    au!
    " Equalize windows when resized
    au VimResized * wincmd =

    " Reload vimrc after editing
    " autocmd BufWritePost .vimrc source $MYVIMRC
    autocmd BufNewFile,BufRead *.txt setfiletype text
    autocmd FileType diff setlocal nolist nospell

    " Ruby functions can have these in thier names
    autocmd FileType eruby,ruby setlocal iskeyword+=!,?
    autocmd BufRead,BufNewFile config.ru,Guardfile set ft=ruby
    autocmd BufRead,BufNewFile *.cjs set ft=javascript

    " Maintain tabs for idiomatic go code
    autocmd FileType go setlocal noexpandtab softtabstop=2 tabstop=2 listchars+=tab:\ \  completeopt-=preview

    " Make upstart files comment correctly
    autocmd FileType upstart setlocal commentstring=#\ %s

    " Help Window Customization {{{
      function! s:SetupHelpWindow()
        wincmd L
        vertical resize 80
        setlocal nonumber winfixwidth colorcolumn=
        setlocal norelativenumber nolist nospell readonly
        setlocal foldexpr& nofoldenable foldmethod& foldcolumn=0

        let b:stl = "#[Branch] HELP#[BranchS] [>] #[FileNameS][>>]%* %=#[LinePercentS][<<]#[LinePercent] %p%% "

        autocmd BufWinEnter <buffer> call <SID>SetupHelpWindow()
        nnoremap <buffer> <Space> <C-]>
        nnoremap <buffer> <CR> <C-]>
        nnoremap <buffer> <BS> <C-T>
        nnoremap <buffer> <silent> q :bd<CR>
      endfunction

      autocmd FileType help call <SID>SetupHelpWindow()
    " }}}
    " Man Window Customization {{{
      function! s:SetupManWindow()
        wincmd L
        vertical resize 80

        let l:section = match(expand('%:t:r'), "\\d\\+$")
        let l:page = expand('%:t:r:r')
        " This makes sure the manpage gets the right width when opening
        if !exists('w:reprocessing_manpage')
          let w:reprocessing_manpage = 1
          exec ":Man " . l:section . ' ' . l:page
        endif
        setlocal nonumber winfixwidth colorcolumn=
        setlocal norelativenumber nolist nospell readonly
        setlocal foldexpr& nofoldenable foldmethod& foldcolumn=0

        let b:stl = "#[Branch] MANPAGE#[BranchS] [>] #[Filename]%{expand('%:t:r:r')} #[FileNameS][>>]%* %=#[LinePercentS][<<]#[LinePercent] %p%% "

        autocmd BufWinEnter <buffer> call <SID>SetupManWindow()
        nmap <buffer> <Space> <C-]>
        nmap <buffer> <CR> <C-]>
        nmap <buffer> <BS> <C-T>
        nnoremap <buffer> <silent> q :bd<CR>
      endfunction

      " runtime! ftplugin/man.vim
      autocmd FileType man call <SID>SetupManWindow()

      function! s:SetupMan(manpage)
        delcommand Man
        runtime! ftplugin/man.vim
        execute 'Man '.a:manpage
      endfunction

      command! -nargs=+ Man call <SID>SetupMan(<q-args>)
      cabbrev man <C-R>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'Man' : 'man')<CR>
    " }}}
    " Fast escape from insert {{{
      autocmd InsertEnter * set timeoutlen=350
      autocmd InsertLeave * set timeoutlen=700
    " }}}
    " Highighlight cursor row {{{
      autocmd WinEnter,InsertLeave * setlocal cursorline
      autocmd WinLeave,InsertEnter * setlocal nocursorline " }}}
    " Restore last cursor position {{{
      autocmd BufWinEnter *
           \ if &filetype !~ 'commit\c' |
           \   if line("'\"") > 1 && line("'\"") <= line("$") |
           \     exe "normal! g`\"" |
           \     exe "normal! zvzz" |
           \   endif |
           \ endif

    " }}}
    " Auto make directories on save {{{
      autocmd BufWritePre,FileWritePre *
        \ if !isdirectory(expand("<afile>:p:h")) |
        \   call mkdir(expand("<afile>:p:h"), "p") |
        \ endif
    " }}}
  augroup END " }}}
  augroup CompletionSettings " {{{
    au!
    autocmd Filetype *
          \ if &omnifunc == "" |
          \   setlocal omnifunc=syntaxcomplete#Complete |
          \ endif

    autocmd FileType vim,ruby setlocal formatoptions-=o formatoptions-=r
    autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
  augroup END " }}}
  " Statusline {{{
    " Statusline updater {{{
      function! s:StatusLineArrows(stl)
        " if has("gui_running")
          let stl = substitute(a:stl, '\[>>\]',  '', 'g')
          let stl = substitute(stl, '\[>\]', '', 'g')
          let stl = substitute(stl, '\[<<\]',  '', 'g')
          let stl = substitute(stl, '\[<\]', '', 'g')
        " else
        "   let new_stl = substitute(new_stl, '\(\[>>\]\|\[>\]\|\[<<\]\|\[<\]\)', '', 'g')
        " end
        return stl
      endfunction

      " Inspired by StatusLineHighlight by Ingo Karkat
      function! s:StatusLine(new_stl, type, current)
        let current = (a:current ? "" : "NC")
        let type = a:type
        let new_stl = a:new_stl

        " Prepare current buffer specific text
        " Syntax: <CUR> ... </CUR>
        let new_stl = substitute(new_stl, '<CUR>\(.\{-,}\)</CUR>', (a:current ? '\1' : ''), 'g')
        let new_stl = substitute(new_stl, '<NCUR>\(.\{-,}\)</NCUR>', (a:current ? '' : '\1'), 'g')

        " Prepare statusline colors
        " Syntax: #[ ... ]
        let new_stl = substitute(new_stl, '#\[\(\w\+\)\]', '%#StatusLine'.type.'\1'.current.'#', 'g')

        " Append the syntax scope according to most specific rules to enable it, e.g. buffer then global preference
        if exists('b:synid') && !b:synid
        elseif exists('g:synid') && !g:synid
        elseif exists('g:synid') || exists('b:synid')
          let stack = string(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')))
          if stack != '[]'
            let stack = substitute(stack, "\\(\\['\\|'\\]\\)", '', 'g')
            let stack = substitute(stack, "', '", ' [<] ', 'g')
            let new_stl .= '[<] '.stack.' '
          end
        endif

        let new_stl = <SID>StatusLineArrows(new_stl)

        if &l:statusline ==# new_stl
          " Statusline already set, nothing to do
          return
        endif

        if empty(&l:statusline)
          " No statusline is set, use my_stl
          let &l:statusline = new_stl
        else
          " Check if a custom statusline is set
          let plain_stl = substitute(&l:statusline, '%#StatusLine\w\+#', '', 'g')

          if &l:statusline ==# plain_stl
            " A custom statusline is set, don't modify
            return
          endif

          " No custom statusline is set, use new_stl
          let &l:statusline = new_stl
        endif
      endfunction
    " }}}
    " Color dict parser {{{
      function! s:StatusLineColors(colors)
        for type in keys(a:colors)
          for name in keys(a:colors[type])
            let colors = {'c': a:colors[type][name][0], 'nc': a:colors[type][name][1]}
            let type = (type == 'NONE' ? '' : type)
            let name = (name == 'NONE' ? '' : name)

            if exists("colors['c'][0]")
              exec 'hi StatusLine'.type.name.' ctermbg='.colors['c'][0].' ctermfg='.colors['c'][1].' cterm='.colors['c'][2].' guibg='.colors['c'][3].' guifg='.colors['c'][4].' gui='.colors['c'][2]
            endif

            if exists("colors['nc'][0]")
              exec 'hi StatusLine'.type.name.'NC ctermbg='.colors['nc'][0].' ctermfg='.colors['nc'][1].' cterm='.colors['nc'][2].' guibg='.colors['nc'][3].' guifg='.colors['nc'][4].' gui='.colors['nc'][2]
            endif
          endfor
        endfor
      endfunction
    " }}}
    " Color dict {{{
      let s:gui_yellow = "#af8700"
      let s:gui_red    = "#d70000"
      let s:gui_bgbg   = "#1c1c1c"
      let s:gui_botfg  = "#e4e4e4"
      let s:gui_darkbg = "#262626"
      let s:gui_midbg  = "#585858"
      let s:gui_midfg  = "#ffffd7"
      let s:gui_topbg  = "#ffffd7"

      let s:yellow = 3
      let s:red    = 1
      let s:bgbg   = 8
      let s:botfg  = 7
      let s:darkbg = 0
      let s:midbg  = 10
      let s:midfg  = 15
      let s:topbg  = 15

      let s:statuscolors = {
        \   'NONE': {
          \   'NONE'         : [[ s:darkbg, s:midbg, 'bold', s:gui_darkbg, s:gui_midbg], [ s:bgbg, s:darkbg, 'none', s:gui_bgbg, s:gui_darkbg]]
        \ }
        \ , 'Normal': {
          \   'Mode'         : [[ s:yellow,  s:bgbg, 'bold',  s:gui_yellow,  s:gui_bgbg], []]
          \ , 'ModeS'        : [[ s:yellow, s:midbg, 'bold',  s:gui_yellow, s:gui_midbg], []]
          \,  'Branch'       : [[ s:midbg,  s:botfg, 'none',  s:gui_midbg,  s:gui_botfg], [ s:darkbg,  s:midbg, 'none', s:gui_darkbg,  s:gui_midbg]]
          \,  'BranchS'      : [[ s:midbg,  s:midfg, 'bold',  s:gui_midbg,  s:gui_midfg], [ s:darkbg,  s:midbg, 'bold', s:gui_darkbg,  s:gui_midbg]]
          \,  'FileName'     : [[ s:midbg,  s:midfg, 'bold',  s:gui_midbg,  s:gui_midfg], [ s:darkbg,  s:midbg, 'bold', s:gui_darkbg,  s:gui_midfg]]
          \,  'FileNameS'    : [[ s:midbg, s:darkbg, 'bold',  s:gui_midbg, s:gui_darkbg], [ s:darkbg,  s:midbg, 'none', s:gui_darkbg,   s:gui_bgbg]]
          \,  'Error'        : [[ s:midbg,    s:red, 'bold',  s:gui_midbg,    s:gui_red], [ s:darkbg,  s:midbg, 'none', s:gui_darkbg,  s:gui_midbg]]
          \,  'ModFlag'      : [[ s:midbg,    s:red, 'bold',  s:gui_midbg,    s:gui_red], [ s:darkbg,  s:midbg, 'none', s:gui_darkbg,  s:gui_midbg]]
          \,  'BufFlag'      : [[ s:midbg, s:darkbg, 'none',  s:gui_midbg, s:gui_darkbg], [ s:darkbg,  s:midbg, 'none', s:gui_darkbg,  s:gui_midbg]]
          \, 'FunctionName' : [[ s:darkbg,  s:midbg, 'none', s:gui_darkbg,  s:gui_midbg], [ s:darkbg,  s:midbg, 'none',   s:gui_bgbg, s:gui_darkbg]]
          \, 'FileFormat'   : [[ s:darkbg,  s:midbg, 'none', s:gui_darkbg,  s:gui_midbg], [ s:darkbg,  s:midbg, 'none',   s:gui_bgbg, s:gui_darkbg]]
          \, 'FileEncoding' : [[ s:darkbg,  s:midbg, 'none', s:gui_darkbg,  s:gui_midbg], [ s:darkbg,  s:midbg, 'none',   s:gui_bgbg, s:gui_darkbg]]
          \, 'Separator'    : [[ s:darkbg,  s:midbg, 'bold', s:gui_darkbg,  s:gui_midbg], [ s:darkbg,  s:midbg, 'none',   s:gui_bgbg, s:gui_darkbg]]
          \, 'FileType'     : [[ s:darkbg,  s:botfg, 'none', s:gui_darkbg,  s:gui_botfg], [ s:darkbg,  s:midbg, 'none',   s:gui_bgbg, s:gui_darkbg]]
          \,  'LinePercentS' : [[ s:midbg, s:darkbg, 'bold',  s:gui_midbg, s:gui_darkbg], [ s:darkbg,  s:midbg, 'none', s:gui_bgbg,   s:gui_bgbg]]
          \,  'LinePercent'  : [[ s:midbg,  s:midfg, 'none',  s:gui_midbg,  s:gui_midfg], [ s:darkbg,  s:midbg, 'bold', s:gui_bgbg,  s:gui_midbg]]
          \,  'LineNumberS'  : [[ s:topbg,  s:midbg, 'bold',  s:gui_topbg,  s:gui_midbg], [ s:darkbg,  s:midbg, 'none', s:gui_darkbg,  s:gui_bgbg]]
          \,  'LineNumber'   : [[ s:topbg, s:darkbg, 'bold',  s:gui_topbg, s:gui_darkbg], [ s:darkbg,  s:midbg, 'bold', s:gui_darkbg,  s:gui_midbg]]
          \,  'LineColumn'   : [[ s:topbg,  s:midbg, 'none',  s:gui_topbg,  s:gui_midbg], [ s:darkbg,  s:midbg, 'none', s:gui_darkbg,  s:gui_midbg]]
        \ }
        \ , 'Insert': {
          \   'Mode'         : [[ 153,  23, 'bold', '#afd7ff', '#005f5f'], []]
          \ , 'ModeS'        : [[ 153,  31, 'bold', '#afd7ff', '#0087af'], []]
          \ , 'Branch'       : [[  31, 117, 'none', '#0087af', '#87d7ff'], []]
          \ , 'BranchS'      : [[  31, 117, 'bold', '#0087af', '#87d7ff'], []]
          \ , 'FileName'     : [[  31, 231, 'bold', '#0087af', '#ffffff'], []]
          \ , 'FileNameS'    : [[  31,  24, 'bold', '#0087af', '#005f87'], []]
          \ , 'Error'        : [[  31, 202, 'bold', '#0087af', '#ff5f00'], []]
          \ , 'ModFlag'      : [[  31, 196, 'bold', '#0087af', '#ff0000'], []]
          \ , 'BufFlag'      : [[  31,  75, 'none', '#0087af', '#5fafff'], []]
          \ , 'FunctionName' : [[  24, 117, 'none', '#005f87', '#87d7ff'], []]
          \ , 'FileFormat'   : [[  24,  75, 'none', '#005f87', '#5fafff'], []]
          \ , 'FileEncoding' : [[  24,  75, 'none', '#005f87', '#5fafff'], []]
          \ , 'Separator'    : [[  24,  37, 'bold', '#005f87', '#00afaf'], []]
          \ , 'FileType'     : [[  24,  81, 'none', '#005f87', '#5fd7ff'], []]
          \ , 'LinePercentS' : [[  31,  24, 'bold', '#0087af', '#005f87'], []]
          \ , 'LinePercent'  : [[  31, 117, 'none', '#0087af', '#87d7ff'], []]
          \ , 'LineNumberS'  : [[ 117,  31, 'bold', '#87d7ff', '#0087af'], []]
          \ , 'LineNumber'   : [[ 117,  23, 'bold', '#87d7ff', '#005f5f'], []]
          \ , 'LineColumn'   : [[ 117,  31, 'none', '#87d7ff', '#0087af'], []]
        \ }
      \ }
    " }}}
    " Default statusline {{{
      let g:default_stl  = ""
      let g:default_stl .= "<CUR>#[Mode] %{&paste ? 'PASTE [>] ' : ''}%{strtrans(mode())} #[ModeS][>>]</CUR>"
      let g:default_stl .= "#[Branch] %(%{exists('*fugitive#statusline') ? substitute(fugitive#statusline(), 'GIT(\\([a-z0-9\\-_\\./:]\\+\\))', ' \\1', 'gi') : ''}#[BranchS] [>]%)" " Git branch
      let g:default_stl .= "#[ModFlag]%{&readonly ? ' ' : ''}#[FileName] %t " " File name
      let g:syntastic_stl_format = <SID>StatusLineArrows("[>][>][>] SYNTAX [>] %F (%t) [>][>][>]")
      let g:default_stl .= "<CUR>#[Error]%(%{exists('*SyntasticStatuslineFlag') ? SyntasticStatuslineFlag() : ''} %)</CUR>"
      let g:default_stl .= "#[ModFlag]%(%M %)" " Modified flag
      let g:default_stl .= "#[BufFlag]%(%H%W %)" " HLP,PRV flags
      let g:default_stl .= "#[FileNameS]<CUR>[>>]</CUR>" " Separator
      let g:default_stl .= "#[FunctionName] " " Padding/HL group
      let g:default_stl .= "%<" " Truncate right
      let g:default_stl .= "%= " " Right align
      let g:default_stl .= "<CUR>#[FileFormat]%{&fileformat} </CUR>" " File format
      let g:default_stl .= "<CUR>#[FileEncoding]%{(&fenc == '' ? &enc : &fenc)} </CUR>" " File encoding
      let g:default_stl .= "<CUR>#[Separator][<] #[FileType]%{strlen(&ft) ? &ft : 'n/a'} </CUR>" " File type
      let g:default_stl .= "<CUR>#[LinePercentS][<<]#[LinePercent]</CUR> %p%% " " Line percentage
      let g:default_stl .= "#[LineNumberS]<CUR>[<<]</CUR><NCUR>[<] </NCUR>#[LineNumber]"
      let g:default_stl .= " %l#[LineColumn]:%c%V%{&ft =~ 'csv' ? ' C:'.CSV_WCol() : ''} " " Line/column/virtual column, Line percentage
    " }}}
    call <SID>StatusLineColors(s:statuscolors) " Make the status line become colorful on sourcing after startup
  " }}}
  augroup CustomStatusLines " {{{
    au!
    " Custom Status Lines {{{
      " Tagbar {{{
        au BufEnter __Tagbar__ if !exists('b:stl')
              \ | setlocal foldcolumn=1 statusline=
              \ | let b:stl = "#[FileName] Tagbar#[FileNameS] [>>]#[FunctionName] %{g:tagbar_sort ? 'Name' : 'Declaration'}%<%* %=#[LinePercentS][<<]#[LinePercent] %p%% "
              \ | endif
      " }}}
      " Threesome HUD {{{
        au BufEnter __Threesome_HUD__ if !exists('b:stl')
              \ | let b:stl = "#[FileName] Threesome HUD#[FileNameS] [>>]%<%* %="
              \ | endif
      " }}}
      " Scratch {{{
        au BufEnter __Scratch__ if !exists('b:stl')
              \ | let b:stl = "<CUR>#[Mode] %{&paste ? 'PASTE [>] ' : ''}%{strtrans(mode())} #[ModeS][>>]</CUR>#[FileName] Scratch#[FileNameS] [>>]#[FunctionName]%<%=#[LinePercentS][<<]#[LinePercent] %p%% #[LineNumberS][<<]#[LineNumber] %l#[LineColumn]:%c%V"
              \ | endif
              \ | imap <expr><buffer> <Return> exists('b:pane_id') ? "<Esc><S-v>mso" : "<Return>"
              \ | nnoremap <expr><buffer><silent> <Return> exists('b:pane_id') ? "<S-v>\"my:TxSend(@m)<CR>" : "<Return>"
      " }}}
      " Syntastic location list {{{
        au BufEnter \[Location List] if !exists('b:stl')
              \ | let b:stl = "#[FileName]%< Location List #[FileNameS][>>]%* %="
              \ | endif
      " }}}
    " }}}
    " Main Statusline Highlighting {{{
      " These need to happen after the above form them to take effect
      au ColorScheme * call <SID>StatusLineColors(s:statuscolors)
      au BufEnter,BufWinEnter,WinEnter,CmdwinEnter,CursorHold,BufWritePost,InsertLeave * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Normal', 1)
      au BufLeave,BufWinLeave,WinLeave,CmdwinLeave * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Normal', 0)
      au InsertEnter,CursorHoldI * call <SID>StatusLine((exists('b:stl') ? b:stl : g:default_stl), 'Insert', 1)
    "}}}
  augroup END " }}}
  augroup GitShortcuts " {{{
    au!
    autocmd FileType gitrebase
          \ nnoremap <buffer> p :Pick<CR>|
          \ nnoremap <buffer> s :Squash<CR>|
          \ nnoremap <buffer> e :Edit<CR>|
          \ nnoremap <buffer> r :Reword<CR>|
          \ nnoremap <buffer> f :Fixup<CR>|
          \ nnoremap <buffer> <C-j> :m +1<CR>|
          \ nnoremap <buffer> <C-k> :m -2<CR>

    autocmd User Fugitive
          \ nnoremap <silent> <buffer> <Leader>gs :Gstatus<CR>|
          \ nnoremap <silent> <buffer> <Leader>gc :Gcommit<CR>|
          \ nnoremap <silent> <buffer> <Leader>gw :Gwrite<CR>:redraw!<CR>|
          \ nnoremap <silent> <buffer> <Leader>gl :Glog<CR>|
          \ nnoremap <silent> <buffer> <Leader>gd :call <SID>GdiffToggle()<CR>|
          \ nnoremap <silent> <Leader>gv :Gitv --all<CR>|
          \ nnoremap <silent> <Leader>gV :Gitv! --all<CR>

    autocmd FileType gitcommit setlocal spell

    function! s:GdiffToggle()
      if !&diff
        Gdiff
      else
        if bufname('#') =~ '^fugitive:'
          exec bufwinnr('#').'wincmd w'
        endif
        bd
      endif
    endfunction
    " Make running git easier
    cabbrev git <C-R>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'Git' : 'git')<CR>
  augroup END " }}}
  augroup RailsShortcuts " {{{
    au!
    autocmd User Rails
          \ map <buffer> <Leader>grm :Emodel |
          \ map <buffer> <Leader>grc :Econtroller |
          \ map <buffer> <Leader>grv :Eview |
          \ map <buffer> <Leader>gvl :Elayout |
          \ map <buffer> <Leader>gll :Elib |
          \ map <buffer> <Leader>gut :Eunittest |
          \ map <buffer> <Leader>grd :Emigration |
          \ map <buffer> <Leader>gft :Efunctionaltest |
          \ map <buffer> <Leader>git :Eintegrationtest |
          \ map <buffer> <Leader>grs :Espec |
          \ map <buffer> <Leader>gre :Eenvironment |
          \ map <buffer> <Leader>grt :Etask |
          \ map <buffer> <Leader>gro :Eobserver |
          \ map <buffer> <Leader>grj :Ejavascript |
          \ map <buffer> <Leader>gri :Einitializer |
          \ map <buffer> <Leader>grl :Elocale |
          \ map <buffer> <Leader>grh :Ehelper |
          \ map <buffer> <Leader>gam :Emailer |
          \ :Rnavcommand job app/jobs -glob=**/* |
          \ map <buffer> <Leader>gbj :Rjob |

    " automatically make the current working directory be the repo root
    autocmd BufEnter,BufWinEnter * if exists("b:git_dir") | Glcd | endif

    autocmd FileType cucumber set expandtab
  augroup END " }}}
  augroup RubyTestHighlighting " {{{
    au!
    autocmd BufNewFile,BufReadPre *_test.rb syn keyword rubyTestMethod assert assert_block assert_equal assert_in_delta assert_instance_of assert_kind_of assert_match assert_nil assert_no_match assert_not_equal assert_not_nil assert_not_same assert_nothing_raised assert_nothing_thrown assert_operator assert_raise assert_respond_to assert_same assert_send assert_throws flunk assert_difference assert_no_difference assert_named_route tests
  augroup END "}}}
else
  " Custom status line using to show git branch info, has ruler set
  set statusline=%<%f\ %h%m%r%{exists('*fugitive#statusline') ? fugitive#statusline() : ''}%=%-14.(%c%V,%l/%L%)\ %P\ %y
endif

" Folding Config {{{
  if has("folding")
    function! SimpleFold() " {{{
      let line = getline(v:foldstart)

      let nucolwidth = &foldcolumn + (&number + &relativenumber) * &numberwidth
      if &textwidth != 0 && winwidth(0) > &textwidth
        let windowwidth = &textwidth
      else
        let windowwidth = winwidth(0) - nucolwidth - 3
      endif
      let foldedlinecount = v:foldend - v:foldstart

      " expand tabs into spaces
      let onetab = strpart('          ', 0, &tabstop)
      let line = substitute(line, '\t', onetab, 'g')

      let line = strpart(line, 0, windowwidth - 1 - len(foldedlinecount))
      let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
      return line . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
    endfunction " }}}
    set foldtext=SimpleFold()
    set foldcolumn=0
    set foldenable
    set foldmethod=syntax
    set foldlevelstart=99 " How far down fold tree to go before folding code on opening file
    set foldnestmax=10
    set foldminlines=1

    " Make folding not effect insert by disabling it in insert mode
    augroup FoldingInsert
      autocmd!
      " Start with all fold open and foldlevel set to max for file
      autocmd Syntax * normal zR

      " Make folding not effect insert by disabling it in insert mode
      autocmd InsertEnter *
            \ if !exists('w:last_fdm') |
            \   let w:last_fdm = &foldmethod |
            \   setlocal foldmethod=manual |
            \ endif
      autocmd InsertLeave,WinLeave *
            \ if exists('w:last_fdm') |
            \   let &l:foldmethod = w:last_fdm |
            \   unlet w:last_fdm |
            \ endif

      autocmd BufNewFile * setlocal foldlevel=99
    augroup END

    nnoremap <Space> za
    vnoremap <Space> za
  endif
" }}}

function! s:MyFollowSymlink(...)
  let fname = fnameescape(a:0 ? a:1 : expand('%'))
  if getftype(fname) == 'link'
    bwipeout #
    exec 'silent! edit ' . fnameescape(fnamemodify(resolve(fname), ':p'))
  endif
endfunction
command! FollowSymlink call <SID>MyFollowSymlink()

" HTML5 Vim Settings {{{
  let g:event_handler_attributes_complete = 0
  let g:rdfa_attributes_complete = 0
  let g:microdata_attributes_complete = 0
  let g:atia_attributes_complete = 0
" }}}
" Gitv settings {{{
  let g:Gitv_WipeAllOnClose = 1
  let g:Gitv_DoNotMapCtrlKey = 1 " preserves my easy window movement
" }}}
" Syntastic settings {{{
  let g:syntastic_error_symbol = "✗"
  let g:syntastic_warning_symbol = "⚠"
  let g:syntastic_enable_signs = 1
  let g:syntastic_auto_jump = 0
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_objc_compiler = "clang"
  let g:syntastic_objc_compiler_options = "--std=c99"
  let g:syntastic_c_checkers = []
  let g:syntastic_objc_checkers = []
  let g:syntastic_cpp_checkers = []
  let g:syntastic_javascript_checkers = ['jscs', 'eslint']
  let g:syntastic_javascript_eslint_quiet_messages = {
        \ "regex": 'no-console'
        \ }
  let g:syntastic_javascript_jscs_args = '--esnext'
  let g:jasmine_use_templates = 0

  let g:syntastic_html_tidy_blocklevel_tags = [
        \ 'template',
        \ 'emrsn-pinpad',
        \ 'emrsn-panel',
        \ 'panel-header',
        \ 'panel-content',
        \ 'panel-footer',
        \ 'emrsn-dropdown-list',
        \ 'emrsn-list-grid',
        \ 'emrsn-nav-button',
        \ 'emrsn-status-button',
        \ 'emrsn-dial',
        \ 'emrsn-drawer',
        \ 'drawer-content',
        \ 'pull-bar',
        \ 'router-view',
        \ 'require',
        \ 'compose',
        \ 'content'
        \ ]
  let g:syntastic_html_tidy_inline_tags = [
        \ ]
  let g:syntastic_html_tidy_ignore_errors = [
        \ 'unescaped & which should be written as &amp;',
        \ "<link> isn't allowed in <template> elements",
        \ "<style> isn't allowed in <template> elements",
        \ 'proprietary attribute "emrsn-iscroll"',
        \ 'proprietary attribute "emrsn-iscroll.ref"',
        \ 'proprietary attribute "t"',
        \ 'proprietary attribute "ref"',
        \ 'proprietary attribute "css.bind"',
        \ 'proprietary attribute "style.bind"',
        \ 'proprietary attribute "class.bind"',
        \ 'proprietary attribute "repeat.for"',
        \ 'proprietary attribute "if.bind"',
        \ 'proprietary attribute "show.bind"',
        \ 'proprietary attribute "value.bind"',
        \ 'proprietary attribute "view-cache"',
        \ 'proprietary attribute "mousedown.trigger"',
        \ 'proprietary attribute "mousedown.delegate"',
        \ 'proprietary attribute "mouseup.trigger"',
        \ 'proprietary attribute "mouseup.delegate"',
        \ 'proprietary attribute "mouseover.trigger"',
        \ 'proprietary attribute "mouseover.delegate"',
        \ 'proprietary attribute "mousemove.trigger"',
        \ 'proprietary attribute "mousemove.delegate"',
        \ 'proprietary attribute "click.trigger"',
        \ 'proprietary attribute "click.delegate"',
        \ ]

  " let g:ycm_semantic_triggers =  {
  "       \ 'ledger': [':']
  "       \ }
  let g:ycm_collect_identifiers_from_tags_files = 1
  let g:ycm_seed_identifiers_with_syntax = 1
  let g:ycm_complete_in_comments = 1
  let g:ycm_allow_changing_updatetime = 0
  let g:ycm_autoclose_preview_window_after_completion = 1
  let g:ycm_autoclose_preview_window_after_insertion = 1
" }}}
" Ruby Syntax and Completion {{{
  let g:ruby_operators = 1
  let g:rubycomplete_rails = 1
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplete_include_object = 1
  let g:rubycomplete_include_objectspace = 1
  let g:rails_statusline = 0
" }}}
" delimitMate settings {{{
  let g:delimitMate_expand_space = 1
  let g:delimitMate_balance_matchpairs = 1

  " Allow for quick jumping over delimiters instead of S-Tab
  inoremap <silent><expr> ; delimitMate#ShouldJump() ? "<C-R>=delimitMate#JumpAny(';')<CR>" : ";"
" }}}
" Tagbar - the better taglist {{{
  let g:tagbar_width = 40
  let g:tagbar_autoclose = 1
  let g:tagbar_autofocus = 1
  let g:tagbar_sort = 0
  let g:tagbar_compact = 1
  let g:tagbar_indent = 1
  set tags=./tags,tags

  " Add support for markdown files in tagbar.
  let g:tagbar_type_markdown = {
      \ 'ctagstype': 'markdown',
      \ 'ctagsbin' : expand('~/.dotfiles/vim/markdown2ctags.py'),
      \ 'ctagsargs' : '-f - --sort=yes',
      \ 'kinds' : [
          \ 's:sections',
          \ 'i:images'
      \ ],
      \ 'sro' : '|',
      \ 'kind2scope' : {
          \ 's' : 'section',
      \ },
      \ 'sort': 0,
  \ }

  " Make accessing the taglist easier
  nnoremap <silent> <Leader>ll :TagbarToggle<CR>
" }}}
" Undotree settings {{{
  nnoremap <silent> <F5> :UndotreeToggle<CR>
  let g:undotree_SplitWidth = 50
  let g:undotree_SetFocusWhenToggle = 1
" }}}
" EasyMotion settings {{{
  let g:EasyMotion_leader_key = '<Leader>e'
  let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
" }}}
" CtrlP Settings {{{
  " let g:ctrlp_prompt_mappings = { 'MarkToOpen()': ['<c-z>'] }

  " Open files in current window
  let g:ctrlp_open_new_file = 'r'
  let g:ctrlp_open_multiple_files = 'vr'

  let g:ctrlp_extensions = ['commandline']

  " Default to searching from current files dir if not subdirectory of repo
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.git/', 'git --git-dir=%s/.git ls-files --others --cached --exclude-standard'],
      \ 2: ['.hg/', 'hg --cwd %s status -numac -I . $(hg root)'],
    \ },
    \ 'fallback': 'find %s -type f'
  \ }
  map <silent> <Leader>o :<C-U>CtrlPBuffer<CR>
  map <silent> <Leader>m :<C-U>CtrlPMixed<CR>
  map <silent> <Leader>p :<C-U>CtrlP<CR>
  map <silent> <Leader>c :<C-U>CtrlPCommandline<CR>
  command! CtrlPCommandline call ctrlp#init(ctrlp#commandline#id())
" }}}
" ZoomWin mapings {{{
  " Remove default zoomwin mapping
  " if mapcheck('<C-W>o') =~ '<Plug>ZoomWin'
  "   unmap <C-W>o
  "   noremap <silent> <Leader>wo :ZoomWin<CR>
  " endif
" }}}
" UltiSnips settings {{{
  let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
  let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
  let g:SuperTabDefaultCompletionType = '<C-n>'
  let g:UltiSnipsExpandTrigger  = "<tab>"
  let g:UltiSnipsJumpForwardTrigger  = "<tab>"
  let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}
" CSV settings {{{
  let g:csv_hiHeader = 'CSVHiColumnHeader'
  let g:csv_hiGroup = 'CSVHiColumn'
" }}}
" Markdown settings {{{
  if has('macunix')
    nnoremap <silent> <Leader>M :call system('open -g -F -a "Marked 2" '.shellescape(expand('%:p')))<CR>
    if filereadable(expand('~/.dotfiles/mutt/markdown')) && has('autocmd')
      " function! CleanMail()
      "   :normal! :%s/\<c-v>\<esc>[\\d;\\d\\+m
      "   :normal! :g/>   /d2"
      " endfunction
      nnoremap <buffer> <leader>c ma:%s/<c-v><esc>[\d;\d\+m<cr>:g/>\ \ \s* /d2<cr>`a
      augroup MuttMail
        autocmd!
        autocmd BufRead mutt-* set ft=mail.markdown | setlocal fo=wn | execute "normal ,c"
        " autocmd FileType markdown setlocal textwidth=0 fo=wn wrap

        autocmd BufWritePost mutt-* let b:did_write = 1
        autocmd BufUnload mutt-*
              \ | if exists('b:did_write')
              \ |   call system("sed '1,/^$/d' ".expand('%:pS').' | grip --wide - --export /tmp/markdown')
              \ |   call system('cat /tmp/markdown | '.expand('~/.dotfiles/mutt/gfm-mail/bin/gfm-mail').' > /tmp/mutt-mail.html')
              \ | endif
      augroup END
    endif
  endif
" }}}
" Split Join settings {{{
  nnoremap <silent> <Leader>s :SplitjoinSplit<CR>
  nnoremap <silent> <Leader>j :SplitjoinJoin<CR>
  let g:splitjoin_align = 1
  let g:splitjoin_normalize_whitespace = 1
" }}}
" Scratch buffer mapping {{{
  function! s:ScratchToggle() " {{{
    if bufname('%') == '__Scratch__'
      exec 'q'
    else
      exec "silent! normal! :Sscratch\<CR>\<C-W>J:resize 13\<CR>"
    endif
  endfunction
  " }}}
  noremap <silent> <Leader><Tab> :call <SID>ScratchToggle()<CR>
" }}}
" Splice configuration {{{
  let g:splice_initial_mode = "grid"
  let g:splice_initial_diff_grid = 1
  let g:splice_initial_diff_compare = 1
  let g:splice_initial_diff_path = 4
  let g:splice_initial_layout_grid = 1
  let g:splice_initial_layout_compare = 1
  let g:splice_initial_layout_path = 1
  let g:splice_initial_scrollbind_loupe = 1
  let g:splice_initial_scrollbind_compare = 1
  let g:splice_initial_scrollbind_path = 1
" }}}
" Latex Box {{{
  let g:LatexBox_viewer = 'open -a /Applications/Skim.app'
  let g:LatexBox_latexmk_options = '-pvc'
  let g:LatexBox_no_mappings = 1
  map <silent> <Leader>ls :silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-R>=line('.')<CR> "<C-R>=LatexBox_GetOutputFile()<CR>" "%:p" <CR>
" }}}
" Ack {{{
  cabbrev ack <C-R>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'Ack!' : 'ack')<CR>
  if executable('ag')
    cabbrev ag <C-R>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'Ack!' : 'ag')<CR>
    cunabbrev ack
    let g:ack_wildignore = 0
    let g:ackprg = 'ag --vimgrep'
  endif
" }}}
" Objc {{{
  let g:clang_use_library = 1
  " let g:clang_library_path = expand($LPKG_PREFIX . '/lib')
  let g:clang_complete_macros = 1 " Allow preprocessor directives to complete
  let g:clang_complete_patterns = 0 " Don't complete clang snippets
  let g:clang_snippets_engine = 'ultisnips'
  let g:filetype_m = 'objc' " default to .m files being objc
" }}}
" GPG Configuraton {{{
  let g:GPGExecutable = 'gpg2'
  let g:GPGDefaultRecipients = ['cehoffman@ceh.im']
  let g:GPGUsePipes = 1
" }}}
" Ledger {{{
  let g:ledger_maxwidth = 81
  let g:ledger_fillstring = '·'
" }}}
" let g:vitality_fix_focus = 1
let g:tmuxify_map_prefix = 'm'
let g:github_upstream_issues = 1
" Node conviences {{{
  let g:js_indent_flat_switch = 1
  let node#suffixesadd += ['.coffee', '.ls']
  augroup CoffeeScriptExtensions
    au!
    autocmd FileType coffee setlocal nosmartindent foldmethod=indent foldlevel=99
    autocmd FileType ls setlocal nosmartindent foldmethod=indent foldlevel=99
  augroup END
" }}}
" Common projectionist mappings {{{
  nnoremap <silent> <leader>d :Dispatch<CR><CR>
  nnoremap <silent> <leader>qq :ccl<CR>
  map geu :Eunittest |
  map gem :Emodel |
  map gec :Econtroller |
  map gei :Eintegrationtest |
" }}}

" Window Management {{{
  " Open a yanked window {{{
    function! s:HOpen(dir,what_to_open)
      let [type,name] = a:what_to_open

      if a:dir == 'left' || a:dir == 'right'
        vsplit
      elseif a:dir == 'up' || a:dir == 'down'
        split
      end

      if a:dir == 'down' || a:dir == 'right'
        exec "normal! \<C-W>\<C-W>"
      end

      if type == 'buffer'
        exec 'buffer '.name
      else
        exec 'edit '.name
      end
    endfunction
  " }}}
  " Yank a window {{{
    function! s:HYankWindow()
      let s:window = winnr()
      let s:buffer = bufnr('%')
      let s:bufhidden = &bufhidden
    endfunction
  " }}}
  " Delete a window {{{
    function! s:HDeleteWindow()
      call <SID>HYankWindow()
      set bufhidden=hide
      close
    endfunction
  " }}}
  " Paste window in position {{{
    function! s:HPasteWindow(direction)
      let old_buffer = bufnr('%')
      call <SID>HOpen(a:direction,['buffer',s:buffer])
      let s:buffer = old_buffer
      let &bufhidden = s:bufhidden
    endfunction
    " }}}
  " Key Mappings {{{
    " Copy/Pasting buffers to windows around
    noremap <silent> <Leader>wd :call <SID>HDeleteWindow()<cr>
    noremap <silent> <Leader>wy :call <SID>HYankWindow()<cr>
    noremap <silent> <Leader>wpk :call <SID>HPasteWindow('up')<cr>
    noremap <silent> <Leader>wpj :call <SID>HPasteWindow('down')<cr>
    noremap <silent> <Leader>wph :call <SID>HPasteWindow('left')<cr>
    noremap <silent> <Leader>wpl :call <SID>HPasteWindow('right')<cr>
    noremap <silent> <Leader>wpp :call <SID>HPasteWindow('here')<cr>
    noremap <silent> <Leader>wP :call <SID>HPasteWindow('here')<cr>

    " Make moving between windows easy
    noremap <C-J> <C-W>j
    noremap <C-H> <C-W>h
    noremap <C-K> <C-W>k
    noremap <C-L> <C-W>l

    " Opens a vertical window and moves to it
    nnoremap <silent> <Leader>nv :vsplit<CR><C-W><C-W>

    " Opens a horizontal split window and moves to it
    nnoremap <silent> <Leader>ns :split<CR><C-W><C-W>

    " Open a new blank tab
    nnoremap <silent> <Leader>nt :tabnew<CR>

    " Open current window in new tab
    nnoremap <Leader>nT <C-W>T
  " }}}
" }}}

" Custom Functions {{{
  " Trim trailing whitespace {{{
    " This is a function to prevent setting a new search pattern and moving cursor
    function! s:TrimTrailingWhitespace()
      %s/\s*$//
      ''
    endfunction
    nnoremap <silent> <Leader>xx :call <SID>TrimTrailingWhitespace()<CR>
    nnoremap <silent> <Leader>xw :call <SID>TrimTrailingWhitespace()<CR>:w<CR>
  " }}}
  " Paste using pbcopy {{{
    function! s:pbcopy()
      call system("nc localhost 2224", getreg(""))
    endfunction

    command! -nargs=0 -bar PBCopy call s:pbcopy()

    function! s:pbpaste()
      r!pbpaste
    endfunction

    command! -nargs=0 -bar PBPaste call s:pbpaste()
  " }}}
  " Execute bundle for the current project {{{
    cabbrev bundle <C-R>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'Bundle' : 'bundle')<CR>
  " }}}
  " Open url from current line {{{
    function! s:OpenURL()
      let l:uri = matchstr(getline("."), "[a-zA-Z]\\+:\\/\\/\\([a-zA-Z0-9_-]\\+\\.\\)\\+[a-zA-Z]\\+\\(\\/[\\.a-zA-Z0-9_-]\\+\\)*\\ze[^\\.]\\?")
      if !empty(l:uri)
        echo l:uri
        exec "!open " . shellescape(l:uri)
      else
        echo "No URI found in line."
      endif
    endfunction
    map <silent> <Leader>w :call <SID>OpenURL()<CR>
  " }}}
  " */# search in visual mode {{{
    " http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html
    function! s:VSetSearch()
      let clipboard = &clipboard
      try
        set clipboard=
        let temp = @@
        norm! gvy
        let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
        let @@ = temp
        execute "normal! zzzv"
      finally
        let &clipboard = clipboard
      endtry
    endfunction

    vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
    vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>
  " }}}
  " Easy insertion of iso8601 timeformat {{{
    iab i8601 <C-R>=strftime('%Y-%m-%dT%H:%M:%S%z')<CR>
  " }}}
  " Open all quickfix files {{{
    function! s:QuickFixOpenAll()
      if empty(getqflist())
        return
      endif
      let s:prev_val = ""
      for d in getqflist()
        let s:curr_val = bufname(d.bufnr)
        if (s:curr_val != s:prev_val)
          exec "argadd " . s:curr_val
        endif
        let s:prev_val = s:curr_val
      endfor
    endfunction

    command! -nargs=0 -bar QuickFixOpenAll call s:QuickFixOpenAll()
  " }}}
  " Close all hidden buffers {{{
    function! s:CloseHiddenBuffers()
      let open_buffers = []

      for i in range(tabpagenr('$'))
        call extend(open_buffers, tabpagebuflist(i + 1))
      endfor

      for num in range(1, bufnr("$") + 1)
        if buflisted(num) && index(open_buffers, num) == -1
          exec "bdelete ".num
        endif
      endfor
    endfunction
    command! -nargs=0 -bar CloseHiddenBuffers call s:CloseHiddenBuffers()
  " }}}
" }}}

" Local config
if filereadable(expand("~/.vimrc.local"))
  exe 'source '.expand("~/.vimrc.local")
endif

set secure " must be last line in vimrc to have desired effect

" vim: foldminlines=0 foldmethod=marker foldmarker={{{,}}} relativenumber:
