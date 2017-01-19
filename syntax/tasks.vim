" Tasks syntax
" Language:    Tasks
" Maintainer:  Chris Rolfs
" Last Change: Aug 7, 2015
" Version:	   0.1
" URL:         https://github.com/irrationalistic/vim-tasks

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'tasks'
endif

silent! syntax include @markdown syntax/markdown.vim
unlet! b:current_syntax

syn case match
syn sync fromstart

let b:regesc = '[]()?.*@='

function! s:CreateMatch(name, regex)
  exec 'syn match ' . a:name . ' "' . a:regex . '" contained'
endfunc


call s:CreateMatch('tMarker', '^\s*' . escape(g:TasksMarkerBase, b:regesc))
call s:CreateMatch('tMarkerCancelled', '^\s*' . escape(g:TasksMarkerCancelled, b:regesc))
call s:CreateMatch('tMarkerComplete', '^\s*' . escape(g:TasksMarkerDone, b:regesc))

exec 'syn match tAttribute "' . g:TasksAttributeMarker . '\w\+\(([^)]*)\)\=" contained'
exec 'syn match tAttributeCompleted "' . g:TasksAttributeMarker . '\w\+\(([^)]*)\)\=" contained'

syn region tTask start=/^\s*/ end=/$/ oneline keepend contains=tMarker,tAttribute
exec 'syn region tTaskDone start="^[\s]*.*'.g:TasksAttributeMarker.'done" end=/$/ oneline contains=tMarkerComplete,tAttributeCompleted'
exec 'syn region tTaskCancelled start="^[\s]*.*'.g:TasksAttributeMarker.'cancelled" end=/$/ oneline contains=tMarkerCancelled,tAttributeCompleted'


syn match tTitle    "^\%>0l\%<2l\s*.*$"
syn match tProject "^\s*.*:$"
syn match tHeadline1 "^#\s*.*$"
syn match tHeadline2 "^---\s*.*$"
syn match tHeadline3 "^###\s*.*$"

hi def link tMarker Comment
hi def link tMarkerComplete String
hi def link tMarkerCancelled Statement
hi def link tAttribute Special
hi def link tAttributeCompleted Function
hi def link tTaskDone Comment
hi def link tTaskCancelled Comment

hi Title guifg=#4F5B66 gui=bold ctermfg=73
hi Project   guifg=#99C794 ctermfg=73
hi Headline1 guifg=#C594C5 gui=bold ctermfg=73
hi Headline2 guifg=#6699CC gui=bold termfg=50
hi Headline3 guifg=#A7ADBA gui=bold termfg=50

hi def link tTitle Title
hi def link tProject Project
hi def link tHeadline1 Headline1
hi def link tHeadline2 Headline2
hi def link tHeadline3 Headline3
