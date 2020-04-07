" skip this file if not running on work laptop
if hostname() != 'C02Z5395LVDR'
    finish
endif

" use recent version of node for coc.nvim
let g:coc_node_path = '/Users/jason/.nvm/versions/node/v13.12.0/bin/node'
