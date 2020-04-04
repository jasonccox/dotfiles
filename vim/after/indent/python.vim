let b:undo_indent = get(b:, 'undo_indent', '')

setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

let b:undo_indent .= '|setlocal expandtab< tabstop< softtabstop< shiftwidth<'
