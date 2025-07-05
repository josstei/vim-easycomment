function! easycomment#lang#lua#get() abort
    return { 'line': '--', 'block': { 'start': '--[[', 'end': ']]' } }
endfunction
