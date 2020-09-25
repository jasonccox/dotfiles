" This file contains configuration related to the coc.nvim package.

if exists("g:loaded_cocrc")
    finish
endif
let g:loaded_cocrc = 1

" =============================================================================
" SUGGESTED SETTINGS FROM README
" =============================================================================

set updatetime=300      " improve diagnostic message experience
set hidden              " if not set, TextEdit might fail

" =============================================================================
" EXTENSIONS
" =============================================================================

let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-docker',
    \ 'coc-eslint',
    \ 'coc-go',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-marketplace',
    \ 'coc-python',
    \ 'coc-sh',
    \ 'coc-snippets',
    \ 'coc-tsserver',
    \ 'coc-vimlsp',
    \ 'coc-yaml',
\ ]

" =============================================================================
" KEYMAPPINGS
" =============================================================================

" ctrl+n to trigger completion
inoremap <silent><expr> <C-n> coc#refresh()

" enter confirms completion (<C-g>u breaks undo chain)
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" prev diagnostic
nmap <silent> <Leader>[d <Plug>(coc-diagnostic-prev)

" next diagnostic
nmap <silent> <Leader>]d <Plug>(coc-diagnostic-next)

" go to symbol definition
nmap <silent> <Leader>gd <Plug>(coc-definition)

" go to type definition
nmap <silent> <Leader>gt <Plug>(coc-type-definition)

" go to implementation
nmap <silent> <Leader>gi <Plug>(coc-implementation)

" find references
nmap <silent> <Leader>gr <Plug>(coc-references)

" rename current word
nmap <Leader>rn <Plug>(coc-rename)

" format selected region
xmap <Leader>fm  <Plug>(coc-format-selected)
nmap <Leader>fm  <Plug>(coc-format-selected)

" do code action in selected region
xmap <Leader>a  <Plug>(coc-codeaction-selected)
nmap <Leader>a  <Plug>(coc-codeaction-selected)

" do code action on current line
nmap <Leader>ac  <Plug>(coc-codeaction)

" quick fix problem on current line
nmap <Leader>fc  <Plug>(coc-fix-current)

" inside function text object
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)

" around function text object
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

" use :Format to format current buffer
command! -nargs=0 Format :call CocAction('format')

" use :Fold to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use :OI for organize import of current buffer
command! -nargs=0 OI   :call     CocAction('runCommand', 'editor.action.organizeImport')

" show all diagnostics
nnoremap <silent> <Leader>la  :<C-u>CocList diagnostics<cr>

" manage extensions
nnoremap <silent> <Leader>le  :<C-u>CocList extensions<cr>

" show commands
nnoremap <silent> <Leader>lc  :<C-u>CocList commands<cr>

" find symbol of current document
nnoremap <silent> <Leader>lo  :<C-u>CocList outline<cr>

" search workLeader symbols
nnoremap <silent> <Leader>ls  :<C-u>CocList -I symbols<cr>

" resume latest coc list
nnoremap <silent> <Leader>lp  :<C-u>CocListResume<CR>

" do default action for next item.
nnoremap <silent> <Leader>an  :<C-u>CocNext<CR>

" do default action for previous item.
nnoremap <silent> <Leader>an  :<C-u>CocPrev<CR>

augroup coc
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
