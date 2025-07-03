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
