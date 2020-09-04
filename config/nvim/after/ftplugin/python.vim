setlocal tabstop=2
setlocal softtabstop=2
setlocal expandtab
setlocal shiftwidth=2

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

g:ale_python_mypy_options = '--strict'
map <Leader>rr :!python %<CR>
