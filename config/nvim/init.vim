set title

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/lh-brackets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Chiel92/vim-autoformat'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'cespare/vim-toml'
Plug 'posva/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'https://gitlab.com/benjaminrsherman/fzf-tabbed.git', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dag/vim-fish'
call plug#end()

filetype plugin indent on
syn on

set path+=**                          " Search recursively through directories
set autoread                          " Auto reload changed files
set wildmenu                          " Tab autocomplete in command mode
set wildignorecase                    " Ignore case when searching for files
set backspace=indent,eol,start        " http://vi.stackexchange.com/a/2163
set laststatus=1                      " Hide status line
set splitright                        " Open new splits to the right
set splitbelow                        " Open new splits to the bottom
set lazyredraw                        " Reduce the redraw frequency
set ttyfast                           " Send more characters in fast terminals
set nowrap                            " Don't wrap long lines
set nobackup nowritebackup noswapfile " Turn off backup files
set noerrorbells novisualbell         " Turn off visual and audible bells
set hlsearch                          " Highlight search results
set ignorecase smartcase              " Search queries intelligently set case
set incsearch                         " Show search results as you type
set timeoutlen=1000 ttimeoutlen=0     " Remove timeout when hitting escape
set showcmd                           " Show size of visual selection
set formatoptions+=cro                " Continue comments

" interface
set number relativenumber " Enable relative line numbers
set cursorline            " Enable line highlighting
set colorcolumn=90        " Mark 80 characters
set scrolloff=5           " Leave 5 lines of buffer when scrolling
set sidescrolloff=10      " Leave 10 characters of horizontal buffer when scrolling

" color scheme
set background=dark
colorscheme hybrid_material

" Tweaks for file browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide='/\.vs,Build/.*,Libraries/.*,Include/.*,Resources/Objects/.*,Resources/Textures/.*,Pipfile\.lock,tags,\(^\|\s\s\)\zs\.\S\+'

" ctags shortcut
command! MakeTags !ctags -R .

" lh-brackets
let g:usemarks = 0

" git commit formatting
augroup gitsetup
        autocmd!

        " Only set these commands up for git commits
        autocmd FileType gitcommit
                \  hi def link gitcommitOverflow Error
                \| autocmd CursorMoved,CursorMovedI *
                        \  let &l:textwidth = line('.') == 1 ? 70 : 75
augroup end

" autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0

let g:formatdef_astyle='"astyle --mode=c --style=kr"'
let g:formatters_c = ['astyle']
let g:formatters_cpp = ['clangformat']

let g:formatdef_sassconvert='"sass-convert -i"'
let g:formatters_scss = ['sassconvert']

autocmd BufWritePre * execute ':Autoformat'

au BufRead,BufNewFile *.h		set filetype=cpp

let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

" Ripping off from spacemacs
let mapleader = " "
map <Leader><Leader> :

map <Leader>fed :tabe $MYVIMRC <Esc>
map <Leader>fer :so $MYVIMRC <Esc>

map <Leader><Tab> :tabnext <Esc>

" Git config
map <Leader>g :G
map <Leader>gb :Gblame<Esc>
map <Leader>gw :Gwrite<Esc>
map <Leader>gc :Gcommit<Esc>
map <Leader>gs :Gstatus<Esc>
map <Leader>gm :GMove<Space>

map <Leader>g<Space> ``

" Files n searching
map <Leader>fs :w <Esc>
map <Leader>ff :Files<CR>
map <Leader>ft :Tags<CR>
map <Leader>qq :q <Esc>
map <Leader>qa :qa <Esc>

map <Leader>/ :Rg<CR>

" Buffer movement
map <Leader>h :wincmd h<CR>
map <Leader>j :wincmd j<CR>
map <Leader>k :wincmd k<CR>
map <Leader>l :wincmd l<CR>
map <Leader>wh :wincmd h<CR>
map <Leader>wj :wincmd j<CR>
map <Leader>wk :wincmd k<CR>
map <Leader>wl :wincmd l<CR>

map <Leader>rr :!yarn lint<CR>
set wmh=0

"coc
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <Leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <Leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <Leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <Leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <Leader>s  :<C-u>CocList -I symbols<cr>
" Resume latest coc list
nnoremap <silent> <Leader>p  :<C-u>CocListResume<CR>

set statusline^=%{coc#status()}
