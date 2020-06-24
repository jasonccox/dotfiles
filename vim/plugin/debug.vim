" Debugging helpers

" show the syntax highlighting groups at the cursor
" (https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor)
map <Leader>zh :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" show the syntax highlighting groups in use under the cursor
" (https://stackoverflow.com/questions/9464844/how-to-get-group-name-of-highlighting-under-cursor-in-vim)
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
map <Leader>zs :execute SynStack()<CR>
