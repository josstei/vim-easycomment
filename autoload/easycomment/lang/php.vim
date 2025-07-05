function! easycomment#lang#php#get() abort
    return { 'line': '//', 'block': { 'start': '/*', 'end': '*/' } }
endfunction
