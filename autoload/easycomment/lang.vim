function! easycomment#lang#Get() abort
    try
        let l:filetype = &filetype
        let l:func  = 'easycomment#lang#' . l:filetype . '#get'
        let l:val   = call(function(l:func), [])
        return !empty(l:val) ? l:val : ''
    catch /.*/
        throw 'Error while retrieving lang comment value'
    endtry
endfunction
