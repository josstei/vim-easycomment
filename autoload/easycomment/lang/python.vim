function! easycomment#lang#python#get() abort
     return { 'line': '#', 'block': { 'start': '"""', 'end': '"""' } }
endfunction
