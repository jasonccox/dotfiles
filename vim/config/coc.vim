" =============================================================================
" SUGGESTED SETTINGS FROM README
" =============================================================================

set updatetime=300      " improve diagnostic message experience
set hidden              " if not set, TextEdit might fail

" =============================================================================
" KEYMAPPINGS
" =============================================================================

" ctrl+space to trigger completion
inoremap <silent><expr> <C-Space> coc#refresh()

" enter confirms completion (<C-g>u breaks undo chain)
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"   

" [g for prev diagnostic
nmap <silent> [g <Plug>(coc-diagnostic-prev)                    

" ]g for next diagnostic
nmap <silent> ]g <Plug>(coc-diagnostic-next)                    

" gd to go to symbol definition
nmap <silent> gd <Plug>(coc-definition)                         

" gt to go to type definition
nmap <silent> gt <Plug>(coc-type-definition)                    

" gi to go to implementation
nmap <silent> gi <Plug>(coc-implementation)                     

" gr to find references
nmap <silent> gr <Plug>(coc-references)                         

" <leader>rn to rename current word
nmap <leader>rn <Plug>(coc-rename)                              

" <leader>fm to format selected region
xmap <leader>fm  <Plug>(coc-format-selected)                    
nmap <leader>fm  <Plug>(coc-format-selected)                    

" <leader>a to do code action in selected region
xmap <leader>a  <Plug>(coc-codeaction-selected)                 
nmap <leader>a  <Plug>(coc-codeaction-selected)                 

" <leader>ac to do code action on current line
nmap <leader>ac  <Plug>(coc-codeaction)                         

" <leader>f to quick fix problem on current line
nmap <leader>f  <Plug>(coc-fix-current)                         

" if for inside function text object
xmap if <Plug>(coc-funcobj-i)                                   
omap if <Plug>(coc-funcobj-i)                                   

" af for around function text object
xmap af <Plug>(coc-funcobj-a)                                   
omap af <Plug>(coc-funcobj-a)                                   

" use :Format to format current buffer
command! -nargs=0 Format :call CocAction('format')              

" use :Fold to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use :OI for organize import of current buffer
command! -nargs=0 OI   :call     CocAction('runCommand', 'editor.action.organizeImport')

" <space>a to show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

" <space>e to manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>

" <space>c to show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>

" <space>o to find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" <space>s to search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" <space>j to do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>

" <space>k to do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

" <space>p to resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

augroup coc
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
