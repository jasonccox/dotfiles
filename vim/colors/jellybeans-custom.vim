" My own custom version of the Jellybeans colorscheme. Requires the original
" jellybeans.vim colorscheme.
"
" Maintainer:   Jason Cox (jasoncarloscox.com)

" make backgound transparent in tmux so tmux background color change on
" inactive panes is shown; otherwise, just go all black
if !empty($TMUX)
    let s:bg = 'none'
else
    let s:bg = '000000'
endif

let g:jellybeans_overrides = {
\    'background': { 'guibg': s:bg, 'ctermbg': s:bg },
\   'SignColumn': { 'guibg': s:bg, 'ctermbg': s:bg },
\   'GitGutterAdd': { 'guifg': '19BF10', 'ctermfg': '19BF10' },
\   'GitGutterChange': { 'guifg': '1696FF', 'ctermfg': '1696FF' },
\   'GitGutterDelete': { 'guifg': 'FF1622', 'ctermfg': 'FF1622' },
\   'GitGutterChangeDelete': { 'guifg': '7F16FF', 'ctermfg': '7F16FF' }
\}

runtime colors/jellybeans.vim
