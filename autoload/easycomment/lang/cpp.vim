function! easycomment#lang#cpp#get() abort
    return { 'line': '//', 'block': { 'start': '/*', 'end': '*/' } }
endfunction
