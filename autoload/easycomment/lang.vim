function! easycomment#lang#Get() abort
    try
        let l:filetype = &filetype
        let l:func = 'easycomment#lang#' . l:filetype . '#get'
        let l:config = call(function(l:func), [])
        return l:config
    catch /.*/
        return {'line': '', 'block': {}}
    endtry
endfunction

function! easycomment#lang#BlockStart(lang) abort
    let block =  get(lang,'block',{})
    return !empty(block) ? '^\(\s*\)' . escape(lang.block.start, '\') . '\s*' : 1
endfunction
