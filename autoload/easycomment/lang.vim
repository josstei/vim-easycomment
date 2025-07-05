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

function! easycomment#lang#GetConstraints(lang,start,end) abort
    let constraints = {}
    let line        = get(lang,'line','')
    let block       = get(lang,'block',{})
    let multi       = (a:end - a:start) > 0 

    if multi && !empty(block)
        let constraints['start'] = easycomment#lang#StartConstraint(block.start)
        let constraints['end']   = easycomment#lang#EndConstraint(block.end)
    else
        let constraints['start'] = easycomment#lang#StartConstraint(line)
        let constraints['end']   = ''
    endif

    return constraints
endfunction

function! easycomment#lang#StartConstraint(val) abort
    return '^\s*' . escape(a:val, '\')
endfunction

function! easycomment#lang#EndConstraint(val) abort
    return escape(a:val, '\') . '\s*$'
endfunction

