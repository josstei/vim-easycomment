function! easycomment#lang#rust#get() abort
    return { 'line': '//', 'block': { 'start': '/*', 'end': '*/' } }
endfunction
