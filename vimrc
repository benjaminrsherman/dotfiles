set title

set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Bundle 'vim-syntastic/syntastic'
Plugin 'rust-lang/rust.vim'
Bundle 'LucHermitte/lh-vim-lib'
Bundle 'LucHermitte/lh-brackets'
Bundle 'takac/vim-hardtime'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on
syn on

set path+=**
set autoread                          " Auto reload changed files
set wildmenu                          " Tab autocomplete in command mode
set backspace=indent,eol,start        " http://vi.stackexchange.com/a/2163
set laststatus=1                      " Hide status line
set splitright                        " Open new splits to the right
set splitbelow                        " Open new splits to the bottom
set lazyredraw                        " Reduce the redraw frequency
set ttyfast                           " Send more characters in fast terminals
set nowrap                            " Don't wrap long lines
set listchars=extends:→               " Show arrow if line continues rightwards
set listchars+=precedes:←             " Show arrow if line continues leftwards
set nobackup nowritebackup noswapfile " Turn off backup files
set noerrorbells novisualbell         " Turn off visual and audible bells
set hlsearch                          " Highlight search results
set ignorecase smartcase              " Search queries intelligently set case
set incsearch                         " Show search results as you type
set timeoutlen=1000 ttimeoutlen=0     " Remove timeout when hitting escape
set showcmd                           " Show size of visual selection

" interface
set number relativenumber " Enable relative line numbers
set colorcolumn=90        " Mark 90 characters
set scrolloff=5           " Leave 5 lines of buffer when scrolling
set sidescrolloff=10      " Leave 10 characters of horizontal buffer when scrolling

" color scheme
set background=dark
colorscheme hybrid_material
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:enable_transparent_background = 1

" Easy tab navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

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
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:usemarks = 0

" vim-hardtime
let g:hardtime_default_on = 0

" rust.vim
let g:rustfmt_autosave = 1
