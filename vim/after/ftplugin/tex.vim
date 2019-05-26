" Wrapping
setlocal wrap
setlocal linebreak
setlocal nolist

setlocal tabstop=2
setlocal softtabstop=2
setlocal noexpandtab
setlocal shiftwidth=2

setlocal spell spelllang=en_us

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

autocmd FileWritePost,BufWritePost * silent execute "!pdflatex <afile> > /dev/null 2>&1 &" | redraw!
