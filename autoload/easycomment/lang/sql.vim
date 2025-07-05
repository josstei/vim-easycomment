function! easycomment#lang#sql#get() abort
    return { 'line': '--', 'block': { 'start': '/*', 'end': '*/' } }
endfunction
