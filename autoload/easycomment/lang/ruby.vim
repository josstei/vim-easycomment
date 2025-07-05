function! easycomment#lang#ruby#get() abort
    return { 'line': '#', 'block': { 'start': '=begin', 'end': '=end' } }
endfunction
