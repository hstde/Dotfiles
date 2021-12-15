source $VIMRUNTIME/defaults.vim

set number
set mouse=a

noremap <C-Left> :bprev<CR>
noremap <C-Right> :bnext<CR>

colorscheme elflord
filetype indent on
filetype plugin on
filetype on
syntax on
set wildmenu
set ignorecase
set smartcase
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set nocompatible
set cursorline
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set scrolloff=5
set hlsearch
set showmatch
set showmode
set showcmd
set history=1000
set nowrap
set t_Co=256
let g:Powerline_symbols = "fancy"
 
set laststatus=2
set showtabline=2
set list
set listchars=tab:\|\ ,trail:·

function! GitBranch()
    let b:branchValid=1
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! IsBranchValid()
    return get(b:, 'branchValid', 0)
endfunction

function! CachedGitBranch()
    let b:branchname = IsBranchValid() ? b:branchname : GitBranch()
    return b:branchname
endfunction

function! StatuslineGit()
    let l:branchname = CachedGitBranch()
    return strlen(l:branchname) > 0 ? '   '.l:branchname.' ' : ''
endfunction

function! HasBranch()
    let l:branchname = CachedGitBranch()
    return strlen(l:branchname) > 0
endfunction

function SetupStatusLine()
    hi User1 ctermfg=none ctermbg=darkgray cterm=reverse

    set statusline=
    set statusline+=%#CursorColumn#
    set statusline+=%{StatuslineGit()}
    set statusline+=%1*%{HasBranch()?'':''}
    set statusline+=%#StatusLine#
    set statusline+=\ %.40F\ 
    set statusline+=%{&modified?'🖉\ ':''}
    set statusline+=%{&readonly?'\ ':''}
    set statusline+=%=
    set statusline+=\ %{&filetype!=#''?&filetype:'none'}\ 
    set statusline+=\ %{&fileencoding?&fileencoding:&encoding}\ 
    set statusline+=\ %{&fileformat}\ 
    set statusline+=%1*
    set statusline+=%#CursorColumn#
    set statusline+=\ %l:%c\ \ %L
    set statusline+=\ 
endfunction

function! GetTabLine()
    let s = ''
    let tabcounter=0
    for i in range(bufnr('$'))
        let tabnbr = i + 1
        if !buflisted(tabnbr)
            continue
        endif

        let tabcounter = tabcounter + 1
        if tabnbr == bufnr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        let s .= '%' . (tabnbr) . 'T'
        let s .= ' %{GetTabLabel(' . (tabnbr) . ',' . (tabcounter) . ')} '
    endfor
    let s .= '%#TabLineFill#%T'
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999Xclose'
    endif
    return s
endfunction

function! GetTabLabel(n, c)
    return a:c . ":" . bufname(a:n)
endfunction

function SetupTabLine()
    set tabline=
    set tabline=%!GetTabLine()
endfunction

call SetupStatusLine()
call SetupTabLine()
