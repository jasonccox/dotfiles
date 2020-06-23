" Custom colorscheme heavily based on jellybeans.vim
" (github.com/nanotech/jellybeans.vim)

" hex colors, indexed according to 256 color index
" (source: https://jonasjacek.github.io/colors/)
let s:hex_colors = [
    \ "#000000",
    \ "#800000",
    \ "#008000",
    \ "#808000",
    \ "#000080",
    \ "#800080",
    \ "#008080",
    \ "#c0c0c0",
    \ "#808080",
    \ "#ff0000",
    \ "#00ff00",
    \ "#ffff00",
    \ "#0000ff",
    \ "#ff00ff",
    \ "#00ffff",
    \ "#ffffff",
    \ "#000000",
    \ "#00005f",
    \ "#000087",
    \ "#0000af",
    \ "#0000d7",
    \ "#0000ff",
    \ "#005f00",
    \ "#005f5f",
    \ "#005f87",
    \ "#005faf",
    \ "#005fd7",
    \ "#005fff",
    \ "#008700",
    \ "#00875f",
    \ "#008787",
    \ "#0087af",
    \ "#0087d7",
    \ "#0087ff",
    \ "#00af00",
    \ "#00af5f",
    \ "#00af87",
    \ "#00afaf",
    \ "#00afd7",
    \ "#00afff",
    \ "#00d700",
    \ "#00d75f",
    \ "#00d787",
    \ "#00d7af",
    \ "#00d7d7",
    \ "#00d7ff",
    \ "#00ff00",
    \ "#00ff5f",
    \ "#00ff87",
    \ "#00ffaf",
    \ "#00ffd7",
    \ "#00ffff",
    \ "#5f0000",
    \ "#5f005f",
    \ "#5f0087",
    \ "#5f00af",
    \ "#5f00d7",
    \ "#5f00ff",
    \ "#5f5f00",
    \ "#5f5f5f",
    \ "#5f5f87",
    \ "#5f5faf",
    \ "#5f5fd7",
    \ "#5f5fff",
    \ "#5f8700",
    \ "#5f875f",
    \ "#5f8787",
    \ "#5f87af",
    \ "#5f87d7",
    \ "#5f87ff",
    \ "#5faf00",
    \ "#5faf5f",
    \ "#5faf87",
    \ "#5fafaf",
    \ "#5fafd7",
    \ "#5fafff",
    \ "#5fd700",
    \ "#5fd75f",
    \ "#5fd787",
    \ "#5fd7af",
    \ "#5fd7d7",
    \ "#5fd7ff",
    \ "#5fff00",
    \ "#5fff5f",
    \ "#5fff87",
    \ "#5fffaf",
    \ "#5fffd7",
    \ "#5fffff",
    \ "#870000",
    \ "#87005f",
    \ "#870087",
    \ "#8700af",
    \ "#8700d7",
    \ "#8700ff",
    \ "#875f00",
    \ "#875f5f",
    \ "#875f87",
    \ "#875faf",
    \ "#875fd7",
    \ "#875fff",
    \ "#878700",
    \ "#87875f",
    \ "#878787",
    \ "#8787af",
    \ "#8787d7",
    \ "#8787ff",
    \ "#87af00",
    \ "#87af5f",
    \ "#87af87",
    \ "#87afaf",
    \ "#87afd7",
    \ "#87afff",
    \ "#87d700",
    \ "#87d75f",
    \ "#87d787",
    \ "#87d7af",
    \ "#87d7d7",
    \ "#87d7ff",
    \ "#87ff00",
    \ "#87ff5f",
    \ "#87ff87",
    \ "#87ffaf",
    \ "#87ffd7",
    \ "#87ffff",
    \ "#af0000",
    \ "#af005f",
    \ "#af0087",
    \ "#af00af",
    \ "#af00d7",
    \ "#af00ff",
    \ "#af5f00",
    \ "#af5f5f",
    \ "#af5f87",
    \ "#af5faf",
    \ "#af5fd7",
    \ "#af5fff",
    \ "#af8700",
    \ "#af875f",
    \ "#af8787",
    \ "#af87af",
    \ "#af87d7",
    \ "#af87ff",
    \ "#afaf00",
    \ "#afaf5f",
    \ "#afaf87",
    \ "#afafaf",
    \ "#afafd7",
    \ "#afafff",
    \ "#afd700",
    \ "#afd75f",
    \ "#afd787",
    \ "#afd7af",
    \ "#afd7d7",
    \ "#afd7ff",
    \ "#afff00",
    \ "#afff5f",
    \ "#afff87",
    \ "#afffaf",
    \ "#afffd7",
    \ "#afffff",
    \ "#d70000",
    \ "#d7005f",
    \ "#d70087",
    \ "#d700af",
    \ "#d700d7",
    \ "#d700ff",
    \ "#d75f00",
    \ "#d75f5f",
    \ "#d75f87",
    \ "#d75faf",
    \ "#d75fd7",
    \ "#d75fff",
    \ "#d78700",
    \ "#d7875f",
    \ "#d78787",
    \ "#d787af",
    \ "#d787d7",
    \ "#d787ff",
    \ "#d7af00",
    \ "#d7af5f",
    \ "#d7af87",
    \ "#d7afaf",
    \ "#d7afd7",
    \ "#d7afff",
    \ "#d7d700",
    \ "#d7d75f",
    \ "#d7d787",
    \ "#d7d7af",
    \ "#d7d7d7",
    \ "#d7d7ff",
    \ "#d7ff00",
    \ "#d7ff5f",
    \ "#d7ff87",
    \ "#d7ffaf",
    \ "#d7ffd7",
    \ "#d7ffff",
    \ "#ff0000",
    \ "#ff005f",
    \ "#ff0087",
    \ "#ff00af",
    \ "#ff00d7",
    \ "#ff00ff",
    \ "#ff5f00",
    \ "#ff5f5f",
    \ "#ff5f87",
    \ "#ff5faf",
    \ "#ff5fd7",
    \ "#ff5fff",
    \ "#ff8700",
    \ "#ff875f",
    \ "#ff8787",
    \ "#ff87af",
    \ "#ff87d7",
    \ "#ff87ff",
    \ "#ffaf00",
    \ "#ffaf5f",
    \ "#ffaf87",
    \ "#ffafaf",
    \ "#ffafd7",
    \ "#ffafff",
    \ "#ffd700",
    \ "#ffd75f",
    \ "#ffd787",
    \ "#ffd7af",
    \ "#ffd7d7",
    \ "#ffd7ff",
    \ "#ffff00",
    \ "#ffff5f",
    \ "#ffff87",
    \ "#ffffaf",
    \ "#ffffd7",
    \ "#ffffff",
    \ "#080808",
    \ "#121212",
    \ "#1c1c1c",
    \ "#262626",
    \ "#303030",
    \ "#3a3a3a",
    \ "#444444",
    \ "#4e4e4e",
    \ "#585858",
    \ "#626262",
    \ "#6c6c6c",
    \ "#767676",
    \ "#808080",
    \ "#8a8a8a",
    \ "#949494",
    \ "#9e9e9e",
    \ "#a8a8a8",
    \ "#b2b2b2",
    \ "#bcbcbc",
    \ "#c6c6c6",
    \ "#d0d0d0",
    \ "#dadada",
    \ "#e4e4e4",
    \ "#eeeeee"
\]

" convert cterm color to gui color
function! s:cterm_to_gui(cterm)
    if a:cterm == "NONE"
        return "NONE"
    endif

    return s:hex_colors[a:cterm]
endfun

" sets the given group's highlight
function! s:set_hi(group, ctermfg, ctermbg, attr)
    let l:cmd = "highlight " . a:group .
        \ " ctermfg=" . a:ctermfg .
        \ " ctermbg=" . a:ctermbg .
        \ " cterm=" . a:attr .
        \ " guifg=" . s:cterm_to_gui(a:ctermfg) .
        \ " guibg=" . s:cterm_to_gui(a:ctermbg) .
        \ " gui=" . a:attr

    exec l:cmd
endfun

set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif

call s:set_hi("Normal", 188, "NONE", "NONE")
call s:set_hi("CursorLine", "NONE", 234, "NONE")
call s:set_hi("CursorColumn", "NONE", 234, "NONE")
call s:set_hi("MatchParen", 231, 60, "bold")
call s:set_hi("TabLine", 16, 145, "NONE")
call s:set_hi("TabLineFill", 103, "NONE", "NONE")
call s:set_hi("TabLineSel", 16, 255, "NONE")

" Auto-completion
call s:set_hi("Pmenu", 231, 240, "NONE")
call s:set_hi("PmenuSel", 232, 255, "NONE")

call s:set_hi("Visual", "NONE", 237, "NONE")
call s:set_hi("Cursor", "NONE", 153, "NONE")

call s:set_hi("LineNr", 59, "NONE", "NONE")
call s:set_hi("CursorLineNr", 188, "NONE", "NONE")
call s:set_hi("Comment", 244, "NONE", "NONE")
call s:set_hi("Todo", 251, "NONE", "bold")

call s:set_hi("StatusLine", 16, 253, "NONE")
call s:set_hi("StatusLineNC", 231, 16, "NONE")
call s:set_hi("VertSplit", 243, 16, "NONE")
call s:set_hi("WildMenu", 217, 16, "NONE")

call s:set_hi("Folded", 145, 16, "NONE")
call s:set_hi("FoldColumn", 59, 234, "NONE")
call s:set_hi("SignColumn", 243, "NONE", "NONE")
call s:set_hi("ColorColumn", "NONE", 233, "NONE")

call s:set_hi("Title", 71, "NONE", "bold")

call s:set_hi("Constant", 167, "NONE", "NONE")
call s:set_hi("Special", 107, "NONE", "NONE")
call s:set_hi("Delimiter", 66, "NONE", "NONE")

call s:set_hi("String", 107, "NONE", "NONE")
call s:set_hi("StringDelimiter", 58, "NONE", "NONE")

call s:set_hi("Identifier", 183, "NONE", "NONE")
call s:set_hi("Structure", 110, "NONE", "NONE")
call s:set_hi("Function", 222, "NONE", "NONE")
call s:set_hi("Statement", 103, "NONE", "NONE")
call s:set_hi("PreProc", 110, "NONE", "NONE")

hi! link Operator Structure
hi! link Conceal Operator

call s:set_hi("Type", 215, "NONE", "NONE")
call s:set_hi("NonText", 240, "NONE", "NONE")

call s:set_hi("SpecialKey", 238, 234, "NONE")

call s:set_hi("Search", 217, 16, "underline")

call s:set_hi("Directory", 186, "NONE", "NONE")
call s:set_hi("ErrorMsg", "NONE", 88, "NONE")
hi! link Error ErrorMsg
hi! link MoreMsg Special
call s:set_hi("Question", 71, "NONE", "NONE")


" Spell Checking

call s:set_hi("SpellBad", "NONE", 88, "underline")
call s:set_hi("SpellCap", "NONE", 20, "underline")
call s:set_hi("SpellRare", "NONE", 53, "underline")
call s:set_hi("SpellLocal", "NONE", 23, "underline")

" Diff

hi! link diffRemoved Constant
hi! link 49 String

" VimDiff

call s:set_hi("DiffAdd", 193, 22, "NONE")
call s:set_hi("DiffDelete", 16, 52, "NONE")
call s:set_hi("DiffChange", "NONE", 24, "NONE")
call s:set_hi("DiffText", 110, 16, "reverse")

" GitGutter

call s:set_hi("GitGutterAdd", 40, "NONE", "NONE")
call s:set_hi("GitGutterDelete", 196, "NONE", "NONE")
call s:set_hi("GitGutterChange", 33, "NONE", "NONE")

" PHP

hi! link phpFunctions Function
call s:set_hi("StorageClass", 179, "NONE", "NONE")
hi! link phpSuperglobal Identifier
hi! link phpQuoteSingle StringDelimiter
hi! link phpQuoteDouble StringDelimiter
hi! link phpBoolean Constant
hi! link phpNull Constant
hi! link phpArrayPair Operator
hi! link phpOperator Normal
hi! link phpRelation Normal
hi! link phpVarSelector Identifier

" Python

hi! link pythonOperator Statement

" Ruby

hi! link rubySharpBang Comment
call s:set_hi("rubyClass", 30, "NONE", "NONE")
call s:set_hi("rubyIdentifier", 183, "NONE", "NONE")
hi! link rubyConstant Type
hi! link rubyFunction Function

call s:set_hi("rubyInstanceVariable", 183, "NONE", "NONE")
call s:set_hi("rubySymbol", 104, "NONE", "NONE")
hi! link rubyGlobalVariable rubyInstanceVariable
hi! link rubyModule rubyClass
call s:set_hi("rubyControl", 104, "NONE", "NONE")

hi! link rubyString String
hi! link rubyStringDelimiter StringDelimiter
hi! link rubyInterpolationDelimiter Identifier

call s:set_hi("rubyRegexpDelimiter", 53, "NONE", "NONE")
call s:set_hi("rubyRegexp", 162, "NONE", "NONE")
call s:set_hi("rubyRegexpSpecial", 126, "NONE", "NONE")

call s:set_hi("rubyPredefinedIdentifier", 168, "NONE", "NONE")

" Erlang

hi! link erlangAtom rubySymbol
hi! link erlangBIF rubyPredefinedIdentifier
hi! link erlangFunction rubyPredefinedIdentifier
hi! link erlangDirective Statement
hi! link erlangNode Identifier

" Elixir

hi! link elixirAtom rubySymbol


" JavaScript

hi! link javaScriptValue Constant
hi! link javaScriptRegexpString rubyRegexp
hi! link javaScriptTemplateVar StringDelim
hi! link javaScriptTemplateDelim Identifier
hi! link javaScriptTemplateString String

" CoffeeScript

hi! link coffeeRegExp javaScriptRegexpString

" Lua

hi! link luaOperator Conditional

" C

hi! link cFormat Identifier
hi! link cOperator Constant

" Objective-C/Cocoa

hi! link objcClass Type
hi! link cocoaClass objcClass
hi! link objcSubclass objcClass
hi! link objcSuperclass objcClass
hi! link objcDirective rubyClass
hi! link objcStatement Constant
hi! link cocoaFunction Function
hi! link objcMethodName Identifier
hi! link objcMethodArg Normal
hi! link objcMessageName Identifier

" Vimscript

hi! link vimOper Normal

" HTML

hi! link htmlTag Statement
hi! link htmlEndTag htmlTag
hi! link htmlTagName htmlTag

" XML

hi! link xmlTag Statement
hi! link xmlEndTag xmlTag
hi! link xmlTagName xmlTag
hi! link xmlEqual xmlTag
hi! link xmlEntity Special
hi! link xmlEntityPunct xmlEntity
hi! link xmlDocTypeDecl PreProc
hi! link xmlDocTypeKeyword PreProc
hi! link xmlProcessingDelim xmlAttrib

" Debugger.vim

call s:set_hi("DbgCurrent", 195, 25, "NONE")
call s:set_hi("DbgBreakPt", "NONE", 52, "NONE")

" vim-indent-guides

if !exists("g:indent_guides_auto_colors")
  let g:indent_guides_auto_colors = 0
endif
call s:set_hi("IndentGuidesOdd", "NONE", 234, "NONE")
call s:set_hi("IndentGuidesEven", "NONE", 233, "NONE")

" Plugins, etc.

hi! link TagListFileName Directory
call s:set_hi("PreciseJumpTarget", 155, 22, "NONE")

" Cleanup

delfunction s:cterm_to_gui
delfunction s:set_hi
