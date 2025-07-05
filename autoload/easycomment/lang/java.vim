function! easycomment#lang#java#get() abort
    return { 'line': '//', 'block': { 'start': '/*', 'end': '*/' } }
endfunction
