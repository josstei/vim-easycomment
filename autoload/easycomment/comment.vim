function! easycomment#comment#CommentLine(lang, start, end)
    for lnum in range(a:start, a:end)
        let line        = getline(lnum)
        let indent      = easycomment#comment#Indent(line)
        let content     = easycomment#comment#Content(line)
        let newline     = indent . a:lang.line . ' ' . content
        call setline(lnum, newline)
    endfor
endfunction

function! easycomment#comment#UncommentLine(lang, start, end)
    let pattern = '^\(\s*\)' . escape(a:lang.line,'\') . '\s\?'

    for lnum in range(a:start, a:end)
        let line        = getline(lnum)
        let uncommented = substitute(line,pattern, '\1', '')
        call setline(lnum, uncommented)
    endfor
endfunction

function! easycomment#comment#CommentBlock(lang, start, end) abort
    let l:start     = getline(a:start)
    let l:end       = getline(a:end)

    let blockstart  = a:lang.block.start
    let blockend    = a:lang.block.end

    let indent      = easycomment#comment#Indent(l:start)
    let content     = easycomment#comment#Content(l:start)

    call setline(a:start, indent . blockstart . ' ' . content)
    call setline(a:end, l:end . ' ' . a:lang.block.end)
endfunction

function! easycomment#comment#UncommentBlock(lang, start, end) abort
    let l:start     = getline(a:start)
    let l:end       = getline(a:end)

    let blockstart  = a:lang.block.start
    let blockend    = a:lang.block.end

    call setline(a:start,substitute(l:start, blockstart, '\1', ''))
    call setline(a:end,substitute(l:end, blockend, '', ''))
endfunction

function easycomment#comment#Indent(line) abort
    return matchstr(a:line, '^\s*')
endfunction

function easycomment#comment#Content(line) abort
    return substitute(a:line, '^\s*', '', '')
endfunction

function! easycomment#comment#Execute(lnum,str) abort
    call setline(a:lnum, a:str)
endfunction
