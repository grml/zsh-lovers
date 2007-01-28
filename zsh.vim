" Vim syntax file
" Language:	    Zsh shell script
" Maintainer:	    Nikolai Weibull <source@pcppopper.org>
" URL:		    http://www.pcppopper.org/vim/syntax/pcp/zsh/
" Latest Revision:  2004-12-12
" arch-tag:	    2e2c7097-99cb-4b87-a771-3a819b69995e

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Set iskeyword since we need `-' (and potentially others) in keywords.
" For version 5.x: Set it globally
" For version 6.x: Set it locally
if version >= 600
  command -nargs=1 SetIsk setlocal iskeyword=<args>
else
  command -nargs=1 SetIsk set iskeyword=<args>
endif
SetIsk @,48-57,_,-
delcommand SetIsk

" Todo
syn keyword zshTodo         contained TODO FIXME XXX NOTE

" Comments
syn region  zshComment      matchgroup=zshComment start='\%(^\|\s\)#' end='$' contains=zshTodo

" PreProc
syn match   zshPreProc	    '^\%1l#\%(!\|compdef\|autoload\).*$'

" Strings
syn match   zshQuoted       '\\.'
syn region  zshString       matchgroup=zshStringDelimiter start=+"+ end=+"+ contains=zshQuoted,@zshDerefs,@zshSubst
syn region  zshString       matchgroup=zshStringDelimiter start=+'+ end=+'+
" XXX: This should probably be more precise, but Zsh seems a bit confused about it itself
syn region  zshPOSIXString  matchgroup=zshStringDelimiter start=+\$'+ end=+'+ contains=zshQuoted
syn match   zshJobSpec      '%\(\d\+\|?\=\w\+\|[%+-]\)'

" Precommand Modifiers
syn keyword zshPrecommand   noglob nocorrect exec command builtin - time

" Delimiters
syn keyword zshDelimiter    do done

" Conditionals
syn keyword zshConditional  if then elif else fi case in esac select

" Loops
syn keyword zshRepeat       for while until repeat foreach

" Exceptions
syn keyword zshException    always

" Keywords
syn keyword zshKeyword      function nextgroup=zshKSHFunction skipwhite

" Functions
syn match   zshKSHFunction  contained '\k\+'
syn match   zshFunction     '^\s*\k\+\ze\s*()'

" Operators
syn match   zshOperator	    '||\|&&\|;\|&!\='

" Here Documents
if version < 600
  " Do nothing for now TODO: do something
else
  syn region  zshHereDoc  matchgroup=zshRedir start='<<\s*\z(\S*\)' end='^\z1$' contains=@zshSubst
  syn region  zshHereDoc  matchgroup=zshRedir start='<<-\s*\z(\S*\)' end='^\s*\z1$' contains=@zshSubst
  syn region  zshHereDoc  matchgroup=zshRedir start='<<\s*\(["']\)\z(\S*\)\1'  end='^\z1$'
  syn region  zshHereDoc  matchgroup=zshRedir start='<<-\s*\(["']\)\z(\S*\)\1' end='^\s*\z1$'
endif

" Redirections
syn match   zshRedir        '\d\=\(<\|<>\|<<<\|<&\s*[0-9p-]\=\)'
syn match   zshRedir        '\d\=\(>\|>>\|>&\s*[0-9p-]\=\|&>\|>>&\|&>>\)[|!]\='
syn match   zshRedir        '|&\='

" Variable Assignments
syn match   zshVariable	    '\<\h\w*\ze+\=='
" XXX: how safe is this?
syn region  zshVariable	    oneline matchgroup=zshVariable start='\$\@<!\<\h\w*\[' end='\]\ze+\==' contains=@zshSubst

" Variable Dereferencing
syn cluster zshDerefs contains=zshShortDeref,zshLongDeref,zshDeref

if !exists("g:zsh_syntax_variables")
  let s:zsh_syntax_variables = 'all'
else
  let s:zsh_syntax_variables = g:zsh_syntax_variables
endif

syn match zshShortDeref   '\$[!#$*@?_-]\w\@!'
syn match zshShortDeref   '\$[=^~]*[#+]*\d\+\>'

syn match zshLongDeref    '\$\%(ARGC\|argv\|status\|pipestatus\|CPUTYPE\|EGID\|EUID\|ERRNO\|GID\|HOST\|LINENO\|LOGNAME\)'
syn match zshLongDeref    '\$\%(MACHTYPE\|OLDPWD OPTARG\|OPTIND\|OSTYPE\|PPID\|PWD\|RANDOM\|SECONDS\|SHLVL\|signals\)'
syn match zshLongDeref    '\$\%(TRY_BLOCK_ERROR\|TTY\|TTYIDLE\|UID\|USERNAME\|VENDOR\|ZSH_NAME\|ZSH_VERSION\|REPLY\|reply\|TERM\)'

syn match zshDeref	  '\$[=^~]*[#+]*\h\w*\>'

" Commands
syn match   zshCommands     '\%(^\|\s\)[.:]\ze\s'
syn keyword zshCommands     alias autoload bg bindkey break bye cap cd chdir
syn keyword zshCommands     clone comparguments compcall compctl compdescribe
syn keyword zshCommands     compfiles compgroups compquote comptags comptry
syn keyword zshCommands     compvalues continue declare dirs disable disown
syn keyword zshCommands     echo echotc echoti emulate enable eval exec exit
syn keyword zshCommands     export false fc fg functions getcap getln
syn keyword zshCommands     getopts hash history jobs kill let limit
syn keyword zshCommands     log logout popd print printf pushd pushln
syn keyword zshCommands     pwd r read readonly rehash return sched set
syn keyword zshCommands     setcap setopt shift source stat suspend test times
syn keyword zshCommands     trap true ttyctl type ulimit umask unalias
syn keyword zshCommands     unfunction unhash unlimit unset unsetopt vared
syn keyword zshCommands     wait whence where which zcompile zformat zftp zle
syn keyword zshCommands     zmodload zparseopts zprof zpty zregexparse zsocket
syn keyword zshCommands     zstyle ztcp

" Types
syn keyword zshTypes        float integer local typeset

" Switches
" XXX: this may be too much
syn match   zshSwitches     '\s\zs--\=[a-zA-Z0-9-]\+'

" Numbers
syn match   zshNumber	    '[-+]\=0x\x\+\>'
syn match   zshNumber	    '[-+]\=0\o\+\>'
syn match   zshNumber	    '[-+]\=\d\+#[-+]\=\w\+\>'
syn match   zshNumber	    '[-+]\=\d\+\.\d\+\>'

" Substitution
syn cluster zshSubst	    contains=zshSubst,zshOldSubst
syn region  zshSubst        matchgroup=zshSubstDelim transparent start='\$(' skip='\\)' end=')' contains=TOP
syn region  zshSubst        matchgroup=zshSubstDelim transparent start='\$((' skip='\\)' end='))' contains=TOP
syn region  zshSubst	    matchgroup=zshSubstDelim start='\${' skip='\\}' end='}' contains=@zshSubst
syn region  zshOldSubst	    matchgroup=zshSubstDelim start=+`+ skip=+\\`+ end=+`+ contains=TOP,zshOldSubst

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_zsh_syn_inits")
  if version < 508
    let did_zsh_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink zshTodo	    Todo
  HiLink zshComment	    Comment
  HiLink zshPreProc	    PreProc
  HiLink zshQuoted	    SpecialChar
  HiLink zshString	    String
  HiLink zshStringDelimiter zshString
  HiLink zshPOSIXString	    zshString
  HiLink zshJobSpec	    Special
  HiLink zshPrecommand	    Special
  HiLink zshDelimiter	    Keyword
  HiLink zshConditional	    Conditional
  HiLink zshException	    Exception
  HiLink zshRepeat	    Repeat
  HiLink zshKeyword	    Keyword
  HiLink zshFunction	    Function
  HiLink zshKSHFunction	    zshFunction
  HiLink zshHereDoc	    String
  HiLink zshOperator	    Operator
  HiLink zshRedir	    Operator
  HiLink zshVariable	    Identifier
  HiLink zshDereferencing   PreProc
  if s:zsh_syntax_variables =~ 'short\|all'
    HiLink zshShortDeref    zshDereferencing
  else
    HiLink zshShortDeref    None
  endif
  if s:zsh_syntax_variables =~ 'long\|all'
    HiLink zshLongDeref	    zshDereferencing
  else
    HiLink zshLongDeref    None
  endif
  if s:zsh_syntax_variables =~ 'all'
    HiLink zshDeref	    zshDereferencing
  else
    HiLink zshDerefDeref    None
  endif
  HiLink zshCommands	    Keyword
  HiLink zshTypes	    Type
  HiLink zshSwitches	    Special
  HiLink zshNumber	    Number
  HiLink zshSubst	    PreProc
  HiLink zshOldSubst	    zshSubst
  HiLink zshSubstDelim	    zshSubst

  delcommand HiLink
endif

let b:current_syntax = "zsh"

" vim: set sts=2 sw=2:
