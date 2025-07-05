function! easycomment#lang#markdown#get() abort
    return { 'line': '<!--', 'block': { 'start': '<!--', 'end': '-->' } }
endfunction
