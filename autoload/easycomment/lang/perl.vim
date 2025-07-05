function! easycomment#lang#perl#get() abort
    return { 'line': '#', 'block': { 'start': '=pod', 'end': '=cut' } }
endfunction
