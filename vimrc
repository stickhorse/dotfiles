" This must be first, because it changes other options as a side effect.
set nocompatible

" Pathogen initialization {{{
  filetype off
  call pathogen#runtime_append_all_bundles()
" }}}

" General settings {{{
  set backup
  set backupdir=~/.vim/backup
  set nowritebackup
  set noswapfile
  set history=1000         " keep 1000 lines of command line history
  set showcmd              " display incomplete commands
  set incsearch            " do incremental searching
  set virtualedit=all      " allows editing inside of characters that may not actually exist
  set noshowmode           " The must improved statusline makes it trivial to know your mode
  set scrolljump=10        " make the window jump 10 lines when reaching an edge, helpful to prevent slow scrolling
  set scrolloff=10         " Don't put the cursor so close to a windows edge
  set sidescrolloff=7      " sides can be a little more forgiving
  set sidescroll=1         " mode the side by 1
  set visualbell t_vb=     " disable the stupid bell
  set cmdheight=1          " Reduce the number of times the hit enter dialog comes up
  set shortmess+=aI        " Make messages even shorter
  " set colorcolumn=80       " Always be aware of the best file width
  set laststatus=2         " Always display the status line
  set autoindent           " always set auto indenting on
  set smartindent          " automatically adjust the level of indentation with language constructs
  set tabstop=2            " how many spaces to use for a tab
  set softtabstop=2        " number of spaces a tab counts for
  set shiftwidth=2         " how much to shift text when using << or >>
  set expandtab            " expand tabs into spaces
  set shiftround           " when at an odd number of spaces and using >>/<< go to correct multiple
  set smarttab             " Insert the shiftwidth number of space at start of non empty line when using <Tab>
  set number               " show line numbers
  set numberwidth=5        " and always show room for 5
  set ignorecase           " don't use case when searching
  set smartcase            " unless I type an uppercase letter, then care
  set hidden               " Make Vim more accepting of hidden buffer
  set confirm              " Ask me what to do when quiting or saving fails
  set autoread             " Automatically reload files that change on disk
  set showmatch            " Jump to matching }] briefly when typing
  set nostartofline        " Don't jump to start of line as side effect, e.g. <<
  set updatetime=1500      " Make man auto command macros fire quicker, more often
  set pumheight=10         " control how many options are shown before scrolling on auto completion
  set mouse=a              " Turn on mouse support
  set cpoptions+=y         " allow yank commands to be repeated with '.'
  " set gdefault             " make substitutions default to replacing all on line, might break plug-ins not designed well
  set pastetoggle=<F2>     " Paste mode to turn off autoindention
  set fileformats=unix,dos " Make the default fileformat be unix line endings
  set encoding=utf-8       " Make default text encoding utf-8
  set termencoding=utf-8   " Make default termainl encoding utf-8
  set cryptmethod=blowfish " use a strong encryption method for instead of weak one

  if has("gui_running")
    set lazyredraw     " don't redraw the screen during macros
    set clipboard=unnamed,unnamedplus,autoselect " make copying put on the system clipboard and pasting get from it
  endif

  if has("persistent_undo")
    set undofile
    set undodir=~/.vim/undo,tmp
  endif

  if has("spell")
    set spellfile=~/.vim/spell/common.utf-8.add  " store common correct/incorrect works in a shared place
  endif

  " Tab completion options
  " (only complete to the longest unambiguous match, and show a menu)
  set completeopt=longest,menuone,preview
  set wildmode=list:longest,list:full
  set wildignore=*.o,*.rbc,*.obj,*.pyc,.git,CVS,.svn,tags
  set complete=.,t,i,b,w

  set backspace=indent,eol,start " allow backspacing over everything in insert mode
  set formatoptions=cq1lnr
  set textwidth=78
  set wrap linebreak textwidth=0 showbreak=\ \ \ …\  cpoptions+=n " Use soft wrapping, and adjust mappings for edit keys
  set list listchars=tab:▸\ ,eol:¬,precedes:<,extends:>,nbsp:· " Display extra whitespace

  " Enable file type detection.
  filetype plugin indent on

  " Only enable syntax once to prevent losing styles
  if !exists("syntax_on")
    syntax enable
  endif
" }}}

runtime! macros/matchit.vim " Include the matchit macro

let mapleader = "," " \ is the default leader character

" General Mappings {{{
  " Allows moving up by screen lines, not file lines
  map j gj
  map k gk
  map <Up> gk
  map <Down> gj

  " Make for some better autocompletion
  inoremap <C-]> <C-X><C-]>
  inoremap <C-F> <C-X><C-F>

  " Don't use Ex mode, use Q for formatting
  map Q gq

  " Make Y consistent with C and D
  nnoremap Y y$

  " Mode Toggles {{{
    " Toggle spell checking
    nnoremap <Leader>s :set spell!<CR>
    vnoremap <Leader>s :set spell!<CR>

    " Toggle showing whitespace
    nnoremap <Leader>z :set list!<CR>
    vnoremap <Leader>z :set list!<CR>

    " Toggle search highlighting
    nnoremap <Leader>h :set hlsearch!<CR>
    vnoremap <Leader>h :set hlsearch!<CR>

    " Shortcut to redraw screen
    nnoremap <Leader><C-l> :redraw!<CR>
    vnoremap <Leader><C-l> :redraw!<CR>
  " }}}

  " Allow inserting just one stupid character
  nnoremap <Space> :exec "normal i".nr2char(getchar())."\e"<CR>

  " Don't move the cursosr after pasting
  " noremap p p`[
  " noremap P P`[

  " Select just pasted text in last used visual mode
  nnoremap <expr> gp '`[' . visualmode() . '`]'

  " Shortcut to edit .vimrc
  noremap <Leader>ve :edit $MYVIMRC<CR>

  " New Windows {{{
  " }}}

  " Simplistic buffer removal but keeping window
  nnoremap <Leader>bd :bp<BAR>bd #<CR>
  nnoremap <Leader>bw :bp<BAR>bw #<CR>

  " Paste without losing the item being pasted
  vnoremap P p :call setreg(&clipboard =~# 'unnamed' ? '*' : '"', getreg('0')) <CR>

  " Duplicate a selection
  vnoremap D y'>p

  " Better movement in command line
  cnoremap <C-A> <Home>
  cnoremap <C-E> <End>
  cnoremap <C-P> <Up>
  cnoremap <C-N> <Down>
" }}}

" Terminal/GUI Setup {{{
  if has("gui_running")
    set t_Co=256
    " Remove the toolbar
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions+=c
    colorscheme plasticcodewrap
    set guitablabel=%N\ %t%q\ %m[%{tabpagewinnr(tabpagenr())}]

    if has("gui_mac") || has("gui_macvim")
      " set guifont=Akkurat-Mono:h12
      " set guifont=DejaVuSansMono:h12
      set guifont=MesloLGS:h12
    endif

    if has("gui_gnome")
      set term=gnome-256color
      set guifont=Inconsolata\ Medium\ 12
    endif

    if has("gui_win32") || has("gui_win32s")
      set guifont=Consolas:h12
    endif
  else
    " Workaround for making things like arrow keys work under screen
    if $TERM == 'screen*'
      set term=xterm
    elseif $TERM == 'screen-256color'
      set term=xterm-256color
    end

    " Shut CSApprox up so we don't hear any warnings
    let g:CSApprox_verbose_level = 0

    " Color scheme
    set background=dark
    if &t_Co > 255
      colorscheme plasticcodewrap
    else
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
      let label .= '%' . (i == current ? '#TabLineSel#' : '#TabLine#') . ' %' . i . 'T'

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
      let label .= '[' . tabpagewinnr(i, '$') . ']'
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
    " Reload vimrc after editing
    autocmd BufWritePost .vimrc source $MYVIMRC
    autocmd BufNewFile,BufRead *.txt setfiletype text
    autocmd FileType diff setlocal nolist

    " Ruby functions can have these in thier names
    autocmd FileType eruby,ruby setlocal iskeyword+=!,?
    autocmd BufRead,BufNewFile config.ru,Guardfile set ft=ruby

    " Help Window Customization {{{
      function! s:SetupHelpWindow()
        wincmd L
        vertical resize 80
        setlocal nonumber winfixwidth colorcolumn=

        let b:stl = "#[Branch] HELP#[BranchS] [>] #[FileNameS][>>]%* %=#[LinePercentS][<<]#[LinePercent] %p%% "

        autocmd BufWinEnter <buffer> call <SID>SetupHelpWindow()
        nnoremap <buffer> <Space> <C-]>
        nnoremap <buffer> <CR> <C-]>
        nnoremap <buffer> <BS> <C-T>
      endfunction

      autocmd FileType help call <SID>SetupHelpWindow()
    " }}}
    " Fast escape from insert {{{
      set notimeout
      set ttimeout
      set timeoutlen=10
      autocmd InsertEnter * set timeout
      autocmd InsertLeave * set notimeout
    " }}}
    " Manpages inside vim  {{{
      runtime! ftplugin/man.vim
      autocmd FileType man
            \ setlocal nolist nofoldenable |
            \ map <buffer> q <ESC>:q!<CR>
    " }}}
    " Highighlight cursor row {{{
      set cursorline
      autocmd WinEnter * setlocal cursorline
      autocmd WinLeave * setlocal nocursorline
    " }}}
    " Restore last cursor position {{{
      autocmd BufReadPost *
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
    autocmd FileType ruby,eruby,haml setlocal omnifunc=rubycomplete#Complete
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


    autocmd FileType vim,ruby setlocal formatoptions-=o
    autocmd FileType nerdtree setlocal nolist nowrap

    " autocmd BufEnter,BufWinEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI *.log :checktime
  augroup END " }}}
  " Statusline {{{
    " Statusline updater {{{
      function! s:StatusLineArrows(stl)
        " if has("gui_running")
          let stl = substitute(a:stl, '\[>>\]',  'Č', 'g')
          let stl = substitute(stl, '\[>\]', 'Ċ', 'g')
          let stl = substitute(stl, '\[<<\]',  'č', 'g')
          let stl = substitute(stl, '\[<\]', 'ċ', 'g')
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

          " No custom statusline is set, use net_stl
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
      let s:statuscolors = {
        \   'NONE': {
          \   'NONE'         : [[ 236, 231, 'bold', '#303030', '#ffffff'], [ 232, 244, 'none', '#080808', '#808080']]
        \ }
        \ , 'Normal': {
          \   'Mode'         : [[ 214, 235, 'bold', '#ffaf00', '#262626'], [                 ]]
          \ , 'ModeS'        : [[ 214, 240, 'bold', '#ffaf00', '#585858'], [                 ]]
          \ , 'Branch'       : [[ 240, 250, 'none', '#585858', '#bcbcbc'], [ 234, 239, 'none', '#1c1c1c', '#4e4e4e']]
          \ , 'BranchS'      : [[ 240, 246, 'bold', '#585858', '#949494'], [ 234, 239, 'bold', '#1c1c1c', '#4e4e4e']]
          \ , 'FileName'     : [[ 240, 231, 'none', '#585858', '#ffffff'], [ 234, 244, 'none', '#1c1c1c', '#808080']]
          \ , 'FileNameS'    : [[ 240, 236, 'bold', '#585858', '#303030'], [ 234, 232, 'bold', '#1c1c1c', '#000000']]
          \ , 'Error'        : [[ 240, 202, 'bold', '#585858', '#ff5f00'], [ 234, 239, 'none', '#1c1c1c', '#4e4e4e']]
          \ , 'ModFlag'      : [[ 240, 196, 'bold', '#585858', '#ff0000'], [ 234, 239, 'none', '#1c1c1c', '#4e4e4e']]
          \ , 'BufFlag'      : [[ 240, 250, 'none', '#585858', '#bcbcbc'], [ 234, 239, 'none', '#1c1c1c', '#4e4e4e']]
          \ , 'FunctionName' : [[ 236, 247, 'none', '#303030', '#9e9e9e'], [ 232, 239, 'none', '#000000', '#4e4e4e']]
          \ , 'FileFormat'   : [[ 236, 244, 'none', '#303030', '#808080'], [ 232, 239, 'none', '#000000', '#4e4e4e']]
          \ , 'FileEncoding' : [[ 236, 244, 'none', '#303030', '#808080'], [ 232, 239, 'none', '#000000', '#4e4e4e']]
          \ , 'Separator'    : [[ 236, 242, 'bold', '#303030', '#6c6c6c'], [ 232, 239, 'none', '#000000', '#4e4e4e']]
          \ , 'FileType'     : [[ 236, 248, 'none', '#303030', '#a8a8a8'], [ 232, 239, 'none', '#000000', '#4e4e4e']]
          \ , 'LinePercentS' : [[ 240, 236, 'bold', '#585858', '#303030'], [ 234, 232, 'bold', '#1c1c1c', '#000000']]
          \ , 'LinePercent'  : [[ 240, 250, 'none', '#585858', '#bcbcbc'], [ 234, 239, 'none', '#1c1c1c', '#4e4e4e']]
          \ , 'LineNumberS'  : [[ 252, 240, 'bold', '#d0d0d0', '#585858'], [ 234, 234, 'bold', '#1c1c1c', '#1c1c1c']]
          \ , 'LineNumber'   : [[ 252, 236, 'bold', '#d0d0d0', '#303030'], [ 234, 244, 'none', '#1c1c1c', '#808080']]
          \ , 'LineColumn'   : [[ 252, 240, 'none', '#d0d0d0', '#585858'], [ 234, 239, 'none', '#1c1c1c', '#4e4e4e']]
        \ }
        \ , 'Insert': {
          \   'Mode'         : [[ 153,  23, 'bold', '#afd7ff', '#005f5f'], [                 ]]
          \ , 'ModeS'        : [[ 153,  31, 'bold', '#afd7ff', '#0087af'], [                 ]]
          \ , 'Branch'       : [[  31, 117, 'none', '#0087af', '#87d7ff'], [                 ]]
          \ , 'BranchS'      : [[  31, 117, 'bold', '#0087af', '#87d7ff'], [                 ]]
          \ , 'FileName'     : [[  31, 231, 'bold', '#0087af', '#ffffff'], [                 ]]
          \ , 'FileNameS'    : [[  31,  24, 'bold', '#0087af', '#005f87'], [                 ]]
          \ , 'Error'        : [[  31, 202, 'bold', '#0087af', '#ff5f00'], [                 ]]
          \ , 'ModFlag'      : [[  31, 196, 'bold', '#0087af', '#ff0000'], [                 ]]
          \ , 'BufFlag'      : [[  31,  75, 'none', '#0087af', '#5fafff'], [                 ]]
          \ , 'FunctionName' : [[  24, 117, 'none', '#005f87', '#87d7ff'], [                 ]]
          \ , 'FileFormat'   : [[  24,  75, 'none', '#005f87', '#5fafff'], [                 ]]
          \ , 'FileEncoding' : [[  24,  75, 'none', '#005f87', '#5fafff'], [                 ]]
          \ , 'Separator'    : [[  24,  37, 'bold', '#005f87', '#00afaf'], [                 ]]
          \ , 'FileType'     : [[  24,  81, 'none', '#005f87', '#5fd7ff'], [                 ]]
          \ , 'LinePercentS' : [[  31,  24, 'bold', '#0087af', '#005f87'], [                 ]]
          \ , 'LinePercent'  : [[  31, 117, 'none', '#0087af', '#87d7ff'], [                 ]]
          \ , 'LineNumberS'  : [[ 117,  31, 'bold', '#87d7ff', '#0087af'], [                 ]]
          \ , 'LineNumber'   : [[ 117,  23, 'bold', '#87d7ff', '#005f5f'], [                 ]]
          \ , 'LineColumn'   : [[ 117,  31, 'none', '#87d7ff', '#0087af'], [                 ]]
        \ }
      \ }
    " }}}
    " Default statusline {{{
      let g:default_stl  = ""
      let g:default_stl .= "<CUR>#[Mode] %{&paste ? 'PASTE [>] ' : ''}%{strtrans(mode())} #[ModeS][>>]</CUR>"
      let g:default_stl .= "#[Branch] %(%{substitute(fugitive#statusline(), 'GIT(\\([a-z0-9\\-_\\./:]\\+\\))', 'ĐĔ \\1', 'gi')}#[BranchS] [>] %)" " Git branch
      let g:default_stl .= "#[ModFlag]%{&readonly ? 'Ē ' : ''}#[FileName]%t " " File name
      let g:syntastic_stl_format = <SID>StatusLineArrows("[>][>][>] SYNTAX đ %F (%t) [>][>][>]")
      let g:default_stl .= "<CUR>#[Error]%(%{SyntasticStatuslineFlag()} %)</CUR>"
      let g:default_stl .= "#[ModFlag]%(%M %)" " Modified flag
      let g:default_stl .= "#[BufFlag]%(%H%W %)" " HLP,PRV flags
      let g:default_stl .= "#[FileNameS][>>]" " Separator
      let g:default_stl .= "#[FunctionName] " " Padding/HL group
      let g:default_stl .= "%<" " Truncate right
      let g:default_stl .= "%= " " Right align
      let g:default_stl .= "<CUR>#[FileFormat]%{&fileformat} </CUR>" " File format
      let g:default_stl .= "<CUR>#[FileEncoding]%{(&fenc == '' ? &enc : &fenc)} </CUR>" " File encoding
      let g:default_stl .= "<CUR>#[Separator][<] Ďď#[FileType]%{strlen(&ft) ? &ft : 'n/a'} </CUR>" " File type
      let g:default_stl .= "#[LinePercentS][<<]#[LinePercent] %p%% " " Line/column/virtual column, Line percentage
      let g:default_stl .= "#[LineNumberS][<<]#[LineNumber]"
      " if has("gui_running")
        let g:default_stl .= "đ"
      " endif
      let g:default_stl .= " %l#[LineColumn]:%c%V " " Line/column/virtual column, Line percentage
    " }}}
    call <SID>StatusLineColors(s:statuscolors) " Make the status line become colorful on sourcing after startup
  " }}}
  augroup CustomStatusLines " {{{
    au!
    " Custom Status Lines {{{
      " Lusty buffer list {{{
        au BufEnter * if bufname("%") == "[LustyExplorer-Buffers]"
          \ | let b:stl = "#[FileName] LustyExplorer#[FileNameS] [>>]#[FunctionName] Buffer List%<%* %=#[LinePercentS][<<]#[LinePercent] %p%%: "
          \ | endif
      " }}}
      " Command-T find {{{
        au BufEnter * if bufname("%") == "GoToFile"
          \ | let b:stl = "#[FileName] Find File#[FileNameS] [>>]%<%* %="
          \ | endif
      " }}}
      " Tagbar {{{
        au BufEnter * if bufname("%") == "__Tagbar__"
          \ | set statusline=
          \ | let b:stl = "#[FileName] Tagbar#[FileNameS] [>>]#[FunctionName] %{g:tagbar_sort ? 'Name' : 'Declaration'}%<%* %=#[LinePercentS][<<]#[LinePercent] %p%% "
          \ | endif
      " }}}
      " Gundo {{{
        au BufEnter * if bufname("%") == "__Gundo__"
          \ | let b:stl = "#[FileName] GUNDO#[FileNameS] [>>]#[FunctionName] Undo tree%<%* %=#[LinePercentS][<<]#[LinePercent] %p%% "
          \ | endif

        au BufEnter * if bufname("%") == "__Gundo_Preview__"
          \ | let b:stl = "#[FileName] GUNDO#[FileNameS] [>>]#[FunctionName] Diff preview%<%* %=#[LinePercentS][<<]#[LinePercent] %p%% "
          \ | endif
      " }}}
      " Syntastic location list {{{
        au BufEnter * if bufname("%") == "[Location List]"
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
        \ nnoremap <buffer> p :Pick<CR> |
        \ nnoremap <buffer> s :Squash<CR> |
        \ nnoremap <buffer> e :Edit<CR> |
        \ nnoremap <buffer> r :Reword<CR> |
        \ nnoremap <buffer> f :Fixup<CR> |
        \ nnoremap <buffer> <C-j> :m +1<CR> |
        \ nnoremap <buffer> <C-k> :m -2<CR>
  augroup END " }}}
  augroup RailsShortcuts " {{{
    au!
    autocmd User Rails
        \ map <buffer> <Leader>rm :Rmodel |
        \ map <buffer> <Leader>rc :Rcontroller |
        \ map <buffer> <Leader>rv :Rview |
        \ map <buffer> <Leader>ru :Runittest |
        \ map <buffer> <Leader>rd :Rmigration |
        \ map <buffer> <Leader>rf :Rintegrationtest |
        \ map <buffer> <Leader>rs :Rspec |
        \ map <buffer> <Leader>re :Renvironment |
        \ map <buffer> <Leader>rr :Rtask |
        \ map <buffer> <Leader>rj :Rjavascript |
        \ map <buffer> <Leader>ri :Rinitializer |
        \ map <buffer> <Leader>rl :Rlocale |
        \ map <buffer> <Leader>rh :Rhelper |
        \ :Rnavcommand observer app/observers -glob=**/* -suffix=_observer.rb |
        \ :Rnavcommand job app/jobs -glob=**/* |
        \ :Rnavcommand compass app/stylesheets -glob=**/* -suffix=.s?ss |
        \ map <buffer> <Leader>ro :Robserver |
        \ map <buffer> <Leader>rb :Rjob |
        \ map <buffer> <Leader>rp :Rcompass |

    " automatically make the current working directory be the repo root
    autocmd BufEnter,BufWinEnter * if exists("b:git_dir") | Gcd | endif

    autocmd FileType cucumber set expandtab
  augroup END " }}}
  augroup RubyTestHighlighting " {{{
    au!
    autocmd BufNewFile,BufReadPre *_test.rb syn keyword rubyTestMethod assert assert_block assert_equal assert_in_delta assert_instance_of assert_kind_of assert_match assert_nil assert_no_match assert_not_equal assert_not_nil assert_not_same assert_nothing_raised assert_nothing_thrown assert_operator assert_raise assert_respond_to assert_same assert_send assert_throws flunk assert_difference assert_no_difference
  augroup END "}}}
else
  " Custom status line using to show git branch info, has ruler set
  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%{rvm#statusline()}\ %-14.(%c%V,%l/%L%)\ %P\ %y
endif

if has("folding")
  " Folding Config {{{
    " set foldenable
    " set foldmethod=syntax
    " set foldlevelstart=99 " How far down fold tree to go before folding code on opening file
    " set foldnestmax=10
    " set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
  " }}}
endif

" Git Fugitive settings {{{
  nnoremap <Leader>gs :Gstatus<CR>
  nnoremap <Leader>gc :Gcommit<CR>
  nnoremap <Leader>ga :Gwrite<CR>:redraw!<CR>
  nnoremap <Leader>gl :Glog<CR>
  nnoremap <Leader>gd :Gdiff<CR>
  nnoremap <Leader>gD :call <SID>GdiffClose()<cr>

  " Make running git easier
  cabbrev git Git

  function! s:GdiffClose() "{{{
    if (&diff == 0 || getbufvar('#', '&diff') == 0) && (bufname('%') !~ '^fugitive:' && bufname('#') !~ '^fugitive:')
      echom "Not in diff view."
      return
    endif

    " close current buffer if alternate is not fugitive but current one is
    if bufname('#') !~ '^fugitive:' && bufname('%') =~ '^fugitive:'
      if bufwinnr("#") == -1
        b #
        bd #
      else
        bd
      endif
    else
      bd #
    endif
  endfunction " }}}
" }}}
" Gitv settings {{{
  let g:Gitv_WipeAllOnClose = 1
  nnoremap <Leader>gv :Gitv --all<CR>
  nnoremap <Leader>gV :Gitv! --all<CR>
" }}}
" Syntastic settings {{{
  let g:syntastic_enable_signs = 1
  let g:syntastic_auto_jump = 0
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_quiet_warnings = 1
" }}}
" Ruby Syntax and Completion {{{
  let g:ruby_operators = 1
  let g:rubycomplete_rails = 1
  let g:rubycomplete_buffer_loading = 1
  let g:rubycomplete_classes_in_global = 1
  let g:rubycomplte_include_object = 1
  let g:rubycomplete_include_objectspace = 1
  let g:rails_statusline = 0
" }}}
" Command-T configuration {{{
  let g:peepopen_loaded = 1 " Disable peepopen when not in gui
  nnoremap <Leader>p :CommandT<CR>
  let g:CommandTMaxHeight=10
" }}}
" Nerd Commenter settings {{{
  let NERDSpaceDelims=1
  let NERDCompactSexyComs=1
  let NERDCommentWholeLinesInVMode=1
" }}}
" delimitMate settings {{{
  let delimitMate_expand_space = 0
  let delimitMate_expand_cr = 0

  " Allow for quick jumping over delimiters instead of S-Tab
  inoremap ; <C-R>=delimitMate#JumpAny(";")<CR>
" }}}
" SuperTab settings {{{
  let g:SuperTabCrMapping = 1
  let g:SuperTabLongestEnhanced = 1
  let g:SuperTabLongestHighlight = 1
  let g:SuperTabDefaultCompletionType = '<c-n>'
" }}}
" Tagbar - the better taglist {{{
  let g:tagbar_width = 40
  let g:tagbar_autoclose = 1
  let g:tagbar_autofocus = 1
  let g:tagbar_sort = 0
  set tags=./tags,tags

  " Make accessing the taglist easier
  nnoremap <Leader>ll :TagbarToggle<CR>
" }}}
" Svndiff config {{{
  let g:svndiff_autoupdate = 1
  let g:svndiff_one_sign_delete = 1
  nnoremap <Leader>sd :call Svndiff()<CR>
  augroup SvnDiffFugitive
    au!
    " autocmd User Fugitive if fugitive#buffer().type('file') && &filetype != 'help' && !&diff | :call Svndiff('next') | endif
  augroup END
" }}}
" Gundo settings {{{
  nnoremap <F5> :GundoToggle<CR>
  " let g:gundo_right = 1
  " let g:gundo_preview_bottom = 1
" }}}
" EasyMotion settings {{{
  let g:EasyMotion_leader_key = '<Leader>e'
  let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
" }}}
" LusyExplorer/Jugler Settings {{{
  " Make using lusty juggler and explorer a bit nicer
  " Using built in mappings now because of easymotion
  " nnoremap <Leader>j :LustyJuggler<CR>
  " nnoremap <Leader>j :LustyBufferExplorer<CR>
  " nnoremap <Leader>f :LustyFilesystemExplorerFromHere<CR>
  " Disable the juggler because it has a terrible bug that causes insert bindings to barf
  " after activitating the juggler and choosing a buffer index that is out of bounds
  let g:loaded_lustyjuggler = 1
" }}}
" NerdTree settings {{{
  let NERDChristmasTree = 1
  let NERDTreeQuitOnOpen = 0
  let NERDTreeShowBookmarks = 1
  let NERDTreeShowHidden = 1
  let NERDTreeWinPos = 'left'
  let NERDTreeWinSize = 30
  let NERDTreeMouseMode = 3 " Don't require double click to open file
  let NERDTreeIgnore=['\~$', '^\.git$', '^\.svn$', '^\.bundle$']
  nmap <Leader>d :NERDTreeToggle<CR>

  " Find in NerdTree!
  nnoremap <silent> <Leader>D :NERDTreeFind<CR>
" }}}
" UltiSnips settings {{{
   let g:UltiSnipsJumpForwardTrigger  = "<tab>"
   let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}
" Parameter Object settings {{{
  let g:no_parameter_object_maps = 1
  " Must not use noremap because other functionality must be triggered
  vmap <silent> ia <Plug>ParameterObjectI
  omap <silent> ia <Plug>ParameterObjectI
  vmap <silent> aa <Plug>ParameterObjectA
  omap <silent> aa <Plug>ParameterObjectA
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
        exec "normal! \<c-w>\<c-w>"
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
    noremap <c-w>d :call <SID>HDeleteWindow()<cr>
    noremap <c-w>y :call <SID>HYankWindow()<cr>
    noremap <c-w>pk :call <SID>HPasteWindow('up')<cr>
    noremap <c-w>pj :call <SID>HPasteWindow('down')<cr>
    noremap <c-w>ph :call <SID>HPasteWindow('left')<cr>
    noremap <c-w>pl :call <SID>HPasteWindow('right')<cr>
    noremap <c-w>pp :call <SID>HPasteWindow('here')<cr>
    noremap <c-w>P :call <SID>HPasteWindow('here')<cr>

    " Make moving between windows easy
    noremap <C-j> <C-w>j
    noremap <C-h> <C-w>h
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>l

    " Opens a vertical window and moves to it
    nnoremap <Leader>nv :vsplit<CR><C-w><C-w>

    " Opens a horizontal split window and moves to it
    nnoremap <Leader>ns :split<CR><C-w><C-w>

    " Open a new blank tab
    nnoremap <Leader>nt :tabnew<CR>

    " Open current window in new tab
    nnoremap <Leader>nT <C-w>T
  " }}}
" }}}

" Custom Functions {{{
  " Trim trailing whitespace {{{
    " This is a function to prevent setting a new search pattern and moving cursor
    function! s:TrimTrailingWhitespace()
      %s/\s*$//
      ''
    endfunction
    nnoremap <Leader>x :call <SID>TrimTrailingWhitespace()<CR>
    nnoremap <Leader>xw :call <SID>TrimTrailingWhitespace()<CR>:w<CR>
  " }}}
  " Paste using pbcopy {{{
    function! s:pbcopy()
      call system("nc localhost 2224", getreg(""))
    endfunction

    command! -nargs=0 -bar PBCopy call s:pbcopy()
  " }}}
  " Execute bundle for the current project {{{
    function! s:bundle()
      if !filereadable('.rvmrc')
        echoerr 'No .rvmrc present to determine environment'
      endif
      exec '!'.system("rvm tools path-identifier .")." -S bundle"
    endfunction

    command! -nargs=0 -bar Bundle call s:bundle()
    cabbrev bundle Bundle
  " }}}
  " Open url from current line {{{
    function! s:OpenURL()
      let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
      echo s:uri
      if s:uri != ""
        exec "!open \"" . s:uri . "\""
      else
        echo "No URI found in line."
      endif
    endfunction
    map <Leader>w :call <SID>OpenURL()<CR>
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
      finally
        let &clipboard = clipboard
      endtry
    endfunction

    vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
    vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>
  " }}}
" }}}

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" set makeprg=script/testdrb\ -Itest\ %
" set efm=%-G%*\\wTest:,%-GLoaded\ %.%#,%-GStarted,%-G,%-GFinished\ in%.%#,%-G%*\\d\ tests%.%#,\ %*\\d\ assertions%.%#,%-GCoverage\ report%.%#,%-G[32m%*\\sPASS[0m\ %m,%E[31m%*\\sFAIL[0m\ %.%#,%Z%*\\s%f:%l:%.%#,%C%*\\s%m%#

" vim: foldmethod=marker foldmarker={{{,}}}
