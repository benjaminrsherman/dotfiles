set title

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
"Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/lh-brackets'
Plug 'takac/vim-hardtime'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Chiel92/vim-autoformat'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
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
"set hlsearch                         " Highlight search results
set ignorecase smartcase              " Search queries intelligently set case
set incsearch                         " Show search results as you type
set timeoutlen=1000 ttimeoutlen=0     " Remove timeout when hitting escape
set showcmd                           " Show size of visual selection

" interface
set number relativenumber " Enable relative line numbers
set cursorline            " Enable line highlighting
set colorcolumn=80        " Mark 80 characters
set scrolloff=5           " Leave 5 lines of buffer when scrolling
set sidescrolloff=10      " Leave 10 characters of horizontal buffer when scrolling

" color scheme
set background=dark
colorscheme hybrid_material
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:enable_transparent_background = 1

" Easy tab navigation
" nnoremap <C-H> :tabprevious<CR>
" nnoremap <C-K> :tabnext<CR>

" Tweaks for file browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide='/\.vs,Build/.*,Libraries/.*,Include/.*,Resources/Objects/.*,Resources/Textures/.*,Pipfile\.lock,tags,\(^\|\s\s\)\zs\.\S\+'

" movement in multiple windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
set wmh=0

" ctags shortcut
command! MakeTags !ctags -R .

" vim-syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_ignore_files = ['.py']

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1

" lh-brackets
let g:usemarks = 0

" vim-hardtime
let g:hardtime_default_on = 0

" rust.vim
let g:rustfmt_autosave = 1

" git commit formatting
augroup gitsetup
        autocmd!

        " Only set these commands up for git commits
        autocmd FileType gitcommit
                \  hi def link gitcommitOverflow Error
                \| autocmd CursorMoved,CursorMovedI *
                        \  let &l:textwidth = line('.') == 1 ? 70 : 75
augroup end

" run Black on buffer write
"autocmd BufWritePre *.py execute ':Black'

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

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

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
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0

let g:formatdef_astyle='"astyle --mode=c --style=kr"'
let g:formatters_c = ['astyle']
let g:formatters_cpp = ['clangformat']

autocmd BufWritePre * execute ':Autoformat'

au BufRead,BufNewFile *.h		set filetype=cpp

" Ripping off from spacemacs
let mapleader = " "
map <Leader><Leader> :

map <Leader>fed :tabe $MYVIMRC <Esc>
map <Leader>fer :so $MYVIMRC <Esc>

map <Leader><Tab> :tabnext <Esc>

map <Leader>g :G
map <Leader>gb :Gblame<Esc>
map <Leader>gw :Gwrite<Esc>
map <Leader>gc :Gcommit<Esc>
map <Leader>gs :Gstatus<Esc>
map <Leader>gm :GMove<Space>

map <Leader>fs :w <Esc>
map <Leader>ff :tabe<Space>
map <Leader>qq :q <Esc>
map <Leader>qa :qa <Esc>
