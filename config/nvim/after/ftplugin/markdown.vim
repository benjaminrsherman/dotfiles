" Wrapping
setlocal wrap
setlocal linebreak
setlocal nolist

" When wrapping text, move through wrapped lines
noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$
nnoremap dd g0dg$
nnoremap yy g0yg$
