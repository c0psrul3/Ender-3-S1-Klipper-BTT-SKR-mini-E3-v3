" Vim syntax file
" Language:	Markdown
" Maintainer:	Ben Williams <benw@plasticboy.com>
" URL:		http://plasticboy.com/markdown-vim-mode/
" Version:	9
" Last Change:  2009 May 18 
" Remark:	Uses HTML syntax file
" Remark:	I don't do anything with angle brackets (<>) because that would too easily
"		easily conflict with HTML syntax
" TODO: 	Handle stuff contained within stuff (e.g. headings within blockquotes)


" Read the HTML syntax to start with
if version < 600
  so <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink hi link <args>
else
  command! -nargs=+ HtmlHiLink hi def link <args>
endif

syn spell toplevel
syn case ignore
syn sync linebreaks=1

"additions to HTML groups
syn region htmlBold     start=/\\\@<!\(^\|\A\)\@=\*\@<!\*\*\*\@!/     end=/\\\@<!\*\@<!\*\*\*\@!\($\|\A\)\@=/   contains=@Spell,htmlItalic
syn region htmlItalic   start=/\\\@<!\(^\|\A\)\@=\*\@<!\*\*\@!/       end=/\\\@<!\*\@<!\*\*\@!\($\|\A\)\@=/      contains=htmlBold,@Spell
syn region htmlBold     start=/\\\@<!\(^\|\A\)\@=_\@<!___\@!/         end=/\\\@<!_\@<!___\@!\($\|\A\)\@=/       contains=htmlItalic,@Spell
syn region htmlItalic   start=/\\\@<!\(^\|\A\)\@=_\@<!__\@!/          end=/\\\@<!_\@<!__\@!\($\|\A\)\@=/        contains=htmlBold,@Spell

" [link](URL) | [link][id] | [link][]
syn region mdLink matchgroup=mdDelimiter      start="\!\?\[" end="\]\ze\s*[[(]" contains=@Spell nextgroup=mdURL,mdID skipwhite oneline
syn region mdID matchgroup=mdDelimiter        start="\["    end="\]" contained
syn region mdURL matchgroup=mdDelimiter       start="("     end=")"  contained

" Link definitions: [id]: URL (Optional Title)
" TODO handle automatic links without colliding with htmlTag (<URL>)
syn region mdLinkDef matchgroup=mdDelimiter   start="^ \{,3}\zs\[" end="]:" oneline nextgroup=mdLinkDefTarget skipwhite
syn region mdLinkDefTarget start="<\?\zs\S" excludenl end="\ze[>[:space:]\n]"   contained nextgroup=mdLinkTitle,mdLinkDef skipwhite skipnl oneline
syn region mdLinkTitle matchgroup=mdDelimiter start=+"+     end=+"+  contained
syn region mdLinkTitle matchgroup=mdDelimiter start=+'+     end=+'+  contained
syn region mdLinkTitle matchgroup=mdDelimiter start=+(+     end=+)+  contained

"define Markdown groups
syn match  mdLineContinue ".$" contained
syn match  mdRule      /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syn match  mdRule      /^\s*-\s\{0,1}-\s\{0,1}-$/
syn match  mdRule      /^\s*_\s\{0,1}_\s\{0,1}_$/
syn match  mdRule      /^\s*-\{3,}$/
syn match  mdRule      /^\s*\*\{3,5}$/
syn match  mdListItem  "^\s*[-*+]\s\+"
syn match  mdListItem  "^\s*\d\+\.\s\+"
syn match  mdCode      /^\s*\n\(\(\s\{4,}[^ ]\|\t\+[^\t]\).*\n\)\+/
syn match  mdLineBreak /  \+$/
syn region mdCode      start=/\\\@<!`/                   end=/\\\@<!`/
syn region mdCode      start=/\s*``[^`]*/          end=/[^`]*``\s*/
syn region mdBlockquote start=/^\s*>/              end=/$/                 contains=mdLineBreak,mdLineContinue,@Spell
syn region mdCode      start="<pre[^>]*>"         end="</pre>"
syn region mdCode      start="<code[^>]*>"        end="</code>"

"HTML headings
syn region htmlH1       start="^\s*#"                   end="\($\|#\+\)" contains=@Spell
syn region htmlH2       start="^\s*##"                  end="\($\|#\+\)" contains=@Spell
syn region htmlH3       start="^\s*###"                 end="\($\|#\+\)" contains=@Spell
syn region htmlH4       start="^\s*####"                end="\($\|#\+\)" contains=@Spell
syn region htmlH5       start="^\s*#####"               end="\($\|#\+\)" contains=@Spell
syn region htmlH6       start="^\s*######"              end="\($\|#\+\)" contains=@Spell
syn match  htmlH1       /^.\+\n=\+$/ contains=@Spell
syn match  htmlH2       /^.\+\n-\+$/ contains=@Spell

"highlighting for Markdown groups
HtmlHiLink mdString	    String
HtmlHiLink mdCode          String
HtmlHiLink mdBlockquote    Comment
HtmlHiLink mdLineContinue  Comment
HtmlHiLink mdListItem      Identifier
HtmlHiLink mdRule          Identifier
HtmlHiLink mdLineBreak     Todo
HtmlHiLink mdLink          htmlLink
HtmlHiLink mdURL           htmlString
HtmlHiLink mdID            Identifier
HtmlHiLink mdLinkDef       mdID
HtmlHiLink mdLinkDefTarget mdURL
HtmlHiLink mdLinkTitle     htmlString

HtmlHiLink mdDelimiter     Delimiter

let b:current_syntax = "md"

delcommand HtmlHiLink
" vim: ts=8
