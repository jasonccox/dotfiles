let b:undo_indent = get(b:, 'undo_indent', '')
setlocal noexpandtab
let b:undo_indent .= '|setlocal expandtab<'
