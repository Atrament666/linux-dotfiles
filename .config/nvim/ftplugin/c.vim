set number
nnoremap <F9> :w:make %<
nnoremap <F33> :split \| resize 10 \| term ./%:ri
nnoremap <M-F> :%!astyle --mode=c --style=allman
packadd termdebug
map <F6> :Termdebug
map <F5> :TagbarToggle
map <F4> :call ToggleHeaderSource()

