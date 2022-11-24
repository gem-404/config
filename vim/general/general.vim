
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = '#777777'

set wrap
set noswapfile incsearch
set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab
" set scrolloff=999
set scrolloff=4
set nofoldenable

set ignorecase
set smartcase

set number relativenumber
set termguicolors
set background=dark
set linebreak

" set spell spelllang=en_us
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#filetypes = '\vnotes|help|markdown|rst|org|text|asciidoc|tex|mail|vimwiki'

" autocmd BufEnter * call ncm2#enable_for_buffer()
" set completeopt=noinsert,menuone,noselect

" removing trailing lines and trimming whitespaces
let g:ale_fixers = {
    \'*': ['remove_trailing_lines', 'trim_whitespace'],
    \'javascript': ['prettier', 'eslint'],
    \'css': ['prettier'],
    \'python': ['autoflake', 'autoimport', 'autopep8', 'isort', 'yapf'],
\}

" \           'pyflyby'],
let g:ale_fix_on_save = 1
let g:ale_floating_preview = 1
let g:ale_set_balloons = 1
let g:ale_hover_to_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
" let g:ale_cursor_detail = 1

" augroup ale_hover_cursor
"     autocmd!
"     autocmd CursorHold * ALEHover
" augroup end

" neoformatter for python
let g:neoformat_python_autopep8 = {}
let g:neoformat_enabled_python = ['autopep8', 'yapf', 'docformatter']


"Theme specific
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

:hi CursorLine   cterm=bold ctermbg=white ctermfg=black
:set cursorline

"Goyo Settings
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  :hi CursorLine   cterm=bold ctermbg=white ctermfg=black
  :set cursorline
  Limelight
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  :hi CursorLine   cterm=bold ctermbg=white ctermfg=black
  :set cursorline
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>n :NERDTreeFind<CR>
" Example config in VimScript

let g:gruvbox_baby_function_style = "NONE"
let g:gruvbox_baby_keyword_style = "italic"

" Enable telescope theme

let g:gruvbox_baby_telescope_theme = 1

" Enable transparent mode

let g:gruvbox_baby_transparent_mode = 1

syntax on
syntax enable

vnoremap . :norm.<CR>

let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

" let &t_SI = "\e[6 q"
" let &t_EI = "\e[2 q"

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \}
" Track the engine.
"
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical""


let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusUntrackedFilesMode = 'all'
let g:NERDTreeGitStatusShowClean = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'

let g:tablineclosebutton=1
