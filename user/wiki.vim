"
"
"                                   .__  __    .__ 
"                          __  _  __|__||  | __|__|
"                          \ \/ \/ /|  ||  |/ /|  |
"                           \     / |  ||    < |  |
"                            \/\_/  |__||__|_ \|__|
"                                            \/    
"
" Author: Christiaan Reubsaet
" Github: https://github.com/ctreubsaet

" +----------------------------------------------------------------------------+
" |                               VARIABLES                                    |
" +----------------------------------------------------------------------------+

let WIKI_PERSONAL = $WIKI_PERSONAL
let WIKI_COOKBOOK = $WIKI_COOKBOOK
let WIKI_RESEARCH = $WIKI_RESEARCH

" +----------------------------------------------------------------------------+
" |                             CONFIGURATION                                  |
" +----------------------------------------------------------------------------+

" Personal wiki
let wiki_personal = {}
let wiki_personal.path = WIKI_PERSONAL
let wiki_personal.syntax = 'markdown'
let wiki_personal.ext = '.md'
let wiki_personal.diary_rel_path = 'journal'
let wiki_personal.diary_index = 'index'
let wiki_personal.diary_header = 'Journal'
let wiki_personal.diary_sort = 'asc'

" Cookbook wiki
let wiki_cookbook = {}
let wiki_cookbook.path = WIKI_COOKBOOK
let wiki_cookbook.syntax = 'markdown'
let wiki_cookbook.ext = '.md'
let wiki_cookbook.nested_syntaxes = { 'java': 'java', 'python' : 'python' }

" Research wiki
let wiki_research = {}
let wiki_research.path = WIKI_RESEARCH
let wiki_research.syntax = 'markdown'
let wiki_research.ext = '.md'
let wiki_research.nested_syntaxes = { 'java': 'java', 'python' : 'python' }

" Create wiki selection list.
let g:vimwiki_list = [ wiki_personal, wiki_cookbook, wiki_research ]
