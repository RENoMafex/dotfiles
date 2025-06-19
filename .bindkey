#!/bin/zsh

builtin bindkey "^U"   undo                 # Undo
builtin bindkey "^H"   fzf-history-widget   # search hist using fzf
builtin bindkey "^S^S" clear-screen         # same as "clear" command
builtin bindkey "^F"   fzf-find-widget        # go to folder using fzf
builtin bindkey "^Q"   push-input           # push back input
builtin bindkey "^E"   end-of-line          # jump to line ending

# from here on its kinda vim inspired
builtin bindkey "^W"   forward-word
builtin bindkey "^B"   backward-word
builtin bindkey "^D"   vi-delete
builtin bindkey "^%"   vi-match-bracket
builtin bindkey "^P"   vi-put-before
