function! easycomment#Comment(comment,start, end)
    let space = a:comment =~ '\s$' ? '' : ' '
    for lnum in range(a:start, a:end)
        let line        = getline(lnum)
        let indent      = matchstr(line, '^\s*')
        let content     = substitute(line, '^\s*', '', '')
        let newline     = indent . a:comment . space . content
        call setline(lnum, newline)
    endfor
endfunction

function! easycomment#Uncomment(comment,start, end) abort
    let pattern = '^\(\s*\)' . a:comment . '\s\?'
    for lnum in range(a:start, a:end)
        let line        = getline(lnum)
        let uncommented = substitute(line, pattern, '\1', '')
        call setline(lnum, uncommented)
    endfor
endfunction

function! easycomment#Toggle(start, end) abort
    let comment = easycomment#lang#Get()
    let pattern = '^\s*' . escape(comment, '\')

    let all_commented = 1
    for lnum in range(a:start, a:end)
        let line = getline(lnum)
        if line =~# '^\s*$'
            continue
        endif
        if line !~# pattern
            let all_commented = 0
            break
        endif
    endfor

    if all_commented
        call easycomment#Uncomment(comment,a:start, a:end)
    else
        call easycomment#Comment(comment,a:start, a:end)
    endif
endfunction
