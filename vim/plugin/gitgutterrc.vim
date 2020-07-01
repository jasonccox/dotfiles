" Configuration specific to GitGutter

let g:gitgutter_grep = 'rg'             " use rg instead of grep
let g:gitgutter_sign_priority=9         " lower priority than coc.nvim's signs

" disable all default mappings
let g:gitgutter_map_keys = 0

" jump to next hunk
nmap <Leader>]h <Plug>(GitGutterNextHunk)

" jump to previous hunk
nmap <Leader>[h <Plug>(GitGutterPrevHunk)

" preview current hunk
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)

" stage current hunk
nmap <Leader>hs <Plug>(GitGutterStageHunk)

" undo current hunk
nmap <Leader>hu <Plug>(GitGutterUndoHunk)

" text object for current hunk
omap ih <Plug>(GitGutterTextObjectInnerPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)

" text object for current hunk, including trailing empty lines
xmap ah <Plug>(GitGutterTextObjectOuterVisual)
omap ah <Plug>(GitGutterTextObjectOuterPending)
