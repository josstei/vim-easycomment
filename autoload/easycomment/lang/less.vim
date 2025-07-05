function! easycomment#lang#less#get() abort
    return { 'line': '//', 'block': { 'start': '/*', 'end': '*/' } }
endfunction
