" Vim syntax file
" Language: Flux (project-local subset)
" Maintainer: Generated from cpp/pl/flux parser/runtime support

if exists("b:current_syntax")
  finish
endif

syn case match

" Comments and attributes
syn match fluxComment "//.*$"
syn match fluxAttribute "@[A-Za-z_][A-Za-z0-9_]*"

" String literals and interpolation
syn match fluxEscape +\\\(n\|r\|t\|\\\|"\|\${\|x\x\x\)+ contained
syn region fluxInterp start=+${+ end=+}+ contained contains=fluxString,fluxNumber,fluxUInt,fluxFloat,fluxDuration,fluxTime,fluxBoolean,fluxKeyword,fluxStatement,fluxTypeKeyword,fluxOperator,fluxBuiltin,fluxBuiltinPkg,fluxCall,fluxNamedArg,fluxMember,fluxTypeVar
syn region fluxString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=fluxEscape,fluxInterp

" Regex literals are only lexed in expression contexts where regex is expected.
" Highlight the common supported cases to avoid treating division as regex.
syn match fluxRegex /\%(\(=\~\|!\~\)\s*\)\@<=\/\([^\/\\]\|\\.\)\+\//
syn match fluxRegex /\%(\(^\|[][(:,]\)\s*\)\@<=\/\([^\/\\]\|\\.\)\+\//

" Scalar literals
syn match fluxTime /\<\d\{4}-\d\{2}-\d\{2}\%(T\d\{2}:\d\{2}:\d\{2}\%(\.\d*\)\?\%(Z\|[+-]\d\{2}:\d\{2}\)\?\)\?\>/
syn match fluxDuration /\<\%(\d\+\%(y\|mo\|w\|d\|h\|m\|s\|ms\|us\|ns\)\)\+\>/
syn match fluxUInt /\<\d\+u\>/
syn match fluxFloat /\<\d\+\.\d*\>\|\<\d*\.\d\+\>/
syn match fluxNumber /\<\d\+\>/
syn keyword fluxBoolean true false

" Keywords
syn keyword fluxStatement package import option builtin testcase return
syn keyword fluxKeyword if then else exists and or not with extends
syn keyword fluxTypeKeyword where dynamic vector stream

" Common builtins implemented by this project runtime
syn keyword fluxBuiltin len string sum mean min max from range filter map limit
syn keyword fluxBuiltin tail keep drop rename duplicate set reduce sort group pivot fill
syn keyword fluxBuiltin elapsed difference derivative distinct count first last union join
syn keyword fluxBuiltin aggregateWindow yield now
syn match fluxBuiltin /\<contains\>/
syn match fluxBuiltinPkg +\<csv\.from\>+
syn match fluxBuiltinPkg +\<regexp\.matchRegexpString\>+

" Function-call names and named arguments
syn match fluxCall +\<[A-Za-z_][A-Za-z0-9_]*\>\ze\s*(+
syn match fluxNamedArg +\<[A-Za-z_][A-Za-z0-9_]*\>\ze\s*:+
syn match fluxMember +\.[A-Za-z_][A-Za-z0-9_]*+
syn match fluxTypeVar +\<[A-Z][A-Za-z0-9_]*\>+

" Operators and punctuation
syn match fluxOperator /|>\|<-\|=>\|=\~\|!\~\|==\|!=\|<=\|>=\|[-+*\/%^<>=]/
syn match fluxDelimiter /[(){}\[\],.:?]/

hi def link fluxComment Comment
hi def link fluxAttribute PreProc
hi def link fluxEscape SpecialChar
hi def link fluxInterp Special
hi def link fluxString String
hi def link fluxRegex String
hi def link fluxTime Constant
hi def link fluxDuration Number
hi def link fluxUInt Number
hi def link fluxFloat Float
hi def link fluxNumber Number
hi def link fluxBoolean Boolean
hi def link fluxStatement Statement
hi def link fluxKeyword Keyword
hi def link fluxTypeKeyword Type
hi def link fluxBuiltin Function
hi def link fluxBuiltinPkg Function
hi def link fluxCall Function
hi def link fluxNamedArg Identifier
hi def link fluxMember Identifier
hi def link fluxTypeVar Type
hi def link fluxOperator Operator
hi def link fluxDelimiter Delimiter

let b:current_syntax = "flux"
