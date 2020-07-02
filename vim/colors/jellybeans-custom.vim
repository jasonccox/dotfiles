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
\   'background': { 'guibg': s:bg, 'ctermbg': s:bg },
\   'ColorColumn': { 'guibg': '101010', 'ctermfg': '101010' },
\   'SignColumn': { 'guibg': s:bg, 'ctermbg': s:bg },
\   'GitGutterAdd': { 'guifg': '19BF10', 'ctermfg': '19BF10' },
\   'GitGutterChange': { 'guifg': '1696FF', 'ctermfg': '1696FF' },
\   'GitGutterDelete': { 'guifg': 'FF1622', 'ctermfg': 'FF1622' },
\   'GitGutterChangeDelete': { 'guifg': '7F16FF', 'ctermfg': '7F16FF' },
\   'StatusLineUnfocused': { 'guifg': 'bbbbbb', 'guibg': '403c41',
\                            'ctermfg': 'bbbbbb', 'ctermbg': '403c41' },
\   'StatusLineNCUnfocused': { 'guifg': '000000', 'guibg': '403c41',
\                              'ctermfg': '000000', 'ctermbg': '403c41' }
\}

let g:jellybeans_use_term_italics = 1

runtime colors/jellybeans.vim

let colors_name = "jellybeans-custom"

" Dim all statuslines when vim loses focus. This requires tmux-focus-events.vim
" to work in tmux, and StatuLineUnfocused and StatusLineNCUnfocused must not be
" exactly the same or else vim will put carets (^^^) in the active window's
" status line.
autocmd FocusLost * highlight! link StatusLine StatusLineUnfocused
autocmd FocusLost * highlight! link StatusLineNC StatusLineNCUnfocused
autocmd FocusGained * highlight! link StatusLine NONE
autocmd FocusGained * highlight! link StatusLineNC NONE

" Disable coc.nvim's underlining because it doesn't always go away when it
" should. Run on VimEnter as well because coc.nvim sets it late in startup, even
" after colorscheme has been set in vimrc.
function! s:disableCocUnderline()
    if g:colors_name == "jellybeans-custom"
        highlight CocUnderline NONE
    endif
endfun
autocmd VimEnter * call s:disableCocUnderline()
autocmd ColorScheme * call s:disableCocUnderline()
